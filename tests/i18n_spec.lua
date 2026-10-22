-- Run from the repository root: lua tests/i18n_spec.lua (Lua 5.1+/LuaJIT).
local root = "micromodules/almanac/"
local count = 0
local function eq(actual, expected)
    count = count + 1
    assert(actual == expected, tostring(actual) .. " ~= " .. tostring(expected))
end
local function locale(language)
    G_reader_settings = { readSetting = function() return language end }
    return dofile(root .. "i18n.lua")
end
local it = locale("it_IT")
eq(it.gettext("Continue reading"), "Continua a leggere")
eq(it.gettext("Unknown message"), "Unknown message")
eq(it.ngettext("day streak", "day streak", 1), "giorno consecutivo")
eq(it.ngettext("day streak", "day streak", 3), "giorni consecutivi")
eq(it.ngettext("book", "books", 0), "libri")
eq(it.ngettext("book", "books", 1), "libro")
eq(it.ngettext("book", "books", 2), "libri")
eq(it.format("%1's books", "ottobre"), "Libri di ottobre")
eq(it.format("%2 / %1", "100%", "Reading"), "Reading / 100%")
eq(it.format("%1 / %1 / %2", "%2", "Book"), "%2 / %2 / Book")
eq(it.format("%1 / %2", "Book"), "Book / %2")
local when = os.time{year = 2026, month = 10, day = 21, hour = 12}
eq(it.date("%A %d %B %Y", when), "mercoledì 21 ottobre 2026")
eq(it.date("%a %b %%B", when), "mer ott %B")
eq(it.monthLetter(7), "L")
eq(it.dayLetter(2), "L")
for _, language in ipairs{ "it", "it-IT", "it_IT.UTF-8", "IT_it" } do
    eq(locale(language).gettext("Close"), "Chiudi")
end
for _, language in ipairs{ "en", "en_GB", "C", "fr_FR", "../../it", "" } do
    local en = locale(language)
    eq(en.gettext("Continue reading"), "Continue reading")
    eq(en.date("%A %B", when), "Wednesday October")
    eq(en.ngettext("book", "books", 0), "books")
    eq(en.ngettext("book", "books", 1), "book")
end
G_reader_settings = nil
eq(dofile(root .. "i18n.lua").gettext("Close"), "Close")
G_reader_settings = {readSetting = function() return false end}
eq(dofile(root .. "i18n.lua").gettext("Close"), "Close")

-- KOReader's active gettext locale can differ from (or exist without) the
-- saved setting. Reading Log must follow the language visible in the UI.
local active_language
package.preload.gettext = function() return {current_lang = active_language} end
for _, saved in ipairs{ "", "en", "it_IT" } do
    active_language = "it_IT"
    package.loaded.gettext = nil
    local active = locale(saved)
    eq(active.gettext("Continue reading"), "Continua a leggere")
    eq(active.language, "it")
    eq(active.language_source, "gettext")
    eq(active.requested_language, "it_IT")
end
active_language = "C"
package.loaded.gettext = nil
eq(locale("it_IT").gettext("Close"), "Close")
active_language = ""
package.loaded.gettext = nil
eq(locale("it_IT").gettext("Close"), "Chiudi")
active_language = "it_IT"
package.loaded.gettext = nil
G_reader_settings = nil
eq(dofile(root .. "i18n.lua").gettext("Close"), "Chiudi")
package.preload.gettext = nil
package.loaded.gettext = nil

-- A catalog that exists but cannot be parsed/executed used to disappear
-- silently. Keep a safe fallback and enough diagnostics to identify the cause.
local original_loadfile = loadfile
local logs = {}
package.preload.logger = function()
    return {info = function(message) logs[#logs + 1] = message end,
        warn = function(message) logs[#logs + 1] = message end}
end
for _, failure in ipairs{ "syntax", "runtime", "not a table" } do
    loadfile = function(path)
        if path == root .. "locales/it.lua" then
            if failure == "syntax" then return nil, "invalid Italian syntax" end
            if failure == "runtime" then return function() error("invalid Italian runtime") end end
            return function() return false end
        end
        return original_loadfile(path)
    end
    logs = {}
    local fallback = locale("it_IT")
    eq(fallback.gettext("Close"), "Close")
    eq(fallback.language, "en")
    assert(logs[1]:find("requested=it_IT source=settings catalog=en", 1, true))
    assert(logs[2]:find("English fallback:", 1, true))
end
loadfile = original_loadfile
package.preload.logger = nil
package.loaded.logger = nil

-- Unsupported locales keep Bookshelf's existing localized dates. A catalog
-- we own must not be relocalized by the host a second time.
package.preload["lib/bookshelf_localdate"] = function()
    return {localize = function() return "Host date" end}
end
eq(locale("fr_FR").date("%B", when), "Host date")
eq(locale("it_IT").date("%B", when), "ottobre")
package.preload["lib/bookshelf_localdate"] = nil
package.loaded["lib/bookshelf_localdate"] = nil

-- Spanish and Brazilian Portuguese
local es = locale("es")
eq(es.gettext("Continue reading"), "Seguir leyendo")
eq(es.ngettext("book", "books", 1), "libro")
eq(es.ngettext("book", "books", 3), "libros")
eq(es.ngettext("day streak", "day streak", 1), "día de racha")
eq(es.date("%A %d %B %Y", when), "miércoles 21 octubre 2026")
eq(es.dayLetter(4), "X")
eq(locale("es_MX").gettext("Close"), "Cerrar")
local pt = locale("pt_BR")
eq(pt.gettext("Continue reading"), "Continuar lendo")
eq(pt.ngettext("book", "books", 2), "livros")
eq(pt.date("%A %d %B", when), "quarta-feira 21 outubro")
eq(pt.monthLetter(3), "M")
eq(locale("pt-BR").gettext("Close"), "Fechar")
eq(locale("pt_BR.UTF-8").gettext("Close"), "Fechar")
-- European Portuguese has no catalog of its own yet: English
eq(locale("pt_PT").gettext("Close"), "Close")

-- All source messages and numbered placeholders must be covered in every catalog.
local catalog, catalog_name
local function decode(literal) return assert(loadstring and loadstring("return " .. literal) or load("return " .. literal))() end
local function checkMessage(message)
    assert(catalog[message], "Missing " .. catalog_name .. " translation: " .. message)
    local function placeholders(s)
        local out = {}
        for n in s:gmatch("%%(%d+)") do out[#out + 1] = n end
        table.sort(out)
        return table.concat(out, ",")
    end
    eq(placeholders(message), placeholders(catalog[message]))
end
for _, code in ipairs{ "it", "es", "pt_br" } do
    catalog, catalog_name = dofile(root .. "locales/" .. code .. ".lua").messages, code
    for _, name in ipairs{ "init", "data", "panels", "settings", "modules" } do
        local file = assert(io.open(root .. name .. ".lua"))
        local source = file:read("*a"); file:close()
        assert(loadfile(root .. name .. ".lua"))
        for literal in source:gmatch('T%(("[^\n]-")%)') do checkMessage(decode(literal)) end
        for literal in source:gmatch('A%.tr%(("[^\n]-")%s*,') do checkMessage(decode(literal)) end
    end
    for _, message in ipairs{ "book", "books", "page", "pages", "day", "days", "minutes" } do checkMessage(message) end
end

-- Load the full kit: IDs, settings keys and user content must stay unchanged.
for _, language in ipairs{ "es", "pt_BR" } do
    locale(language)
    local A = dofile(root .. "init.lua")
    eq(A.module("continue").key, "alm_continue")
    eq(A.thousands(14894), "14.894")
    eq(A.plural(2, "book", "books"), language == "es" and "2 libros" or "2 livros")
    local cmp = A.D.compareFrom({}, "week", "pages", os.date("*t", when), 2)
    eq(cmp.sentence, language == "es" and "Todavía no has leído nada esta semana ni la semana pasada."
        or "Nada lido esta semana nem na semana passada ainda.")
end
for _, language in ipairs{ "C", "it_IT" } do
    locale(language)
    local A = dofile(root .. "init.lua")
    local italian = language == "it_IT"
    eq(A.NAME, "Reading Log")
    eq(A.module("continue").key, "alm_continue")
    eq(A.module("continue").title, "Reading Log · " .. (italian and "Continua a leggere" or "Continue reading"))
    eq(A.Dashboard.key, "alm_dashboard")
    eq(A.thousands(14894), italian and "14.894" or "14,894")
    eq(A.thousands(-1234567), italian and "-1.234.567" or "-1,234,567")
    eq(A.thousands(123), "123")
    eq(A.thousands(1000), italian and "1.000" or "1,000")
    eq(A.decimal(2.5), italian and "2,5" or "2.5")
    eq(A.plural(0, "book", "books"), italian and "0 libri" or "0 books")
    eq(A.plural(1, "book", "books"), italian and "1 libro" or "1 book")
    eq(A.plural(2, "book", "books"), italian and "2 libri" or "2 books")
    eq(A.safe("Reading"), "Reading")
    A.set("dash_label_today", "Reading")
    eq(A.get("dash_label_today"), "Reading")
    A.set("control_buttons", { {label = "Reading", action = {suspend = true}} })
    eq(A.controlButtons(1)[1].label, "Reading")
    eq(A.CONTROL_DEFAULTS[1].action.toggle_wifi, true)
    eq(A.D.TREND_DEFS[1].id, "time")
    eq(A.dashPages()[1].id, "today")
    local cmp = A.D.compareFrom({}, "week", "pages", os.date("*t", when), 2)
    eq(cmp.sentence, italian and "Ancora nessuna lettura nei due periodi: questa settimana / la settimana scorsa." or "Nothing read this week or last week yet.")
end
print("i18n: " .. count .. " assertions passed")
