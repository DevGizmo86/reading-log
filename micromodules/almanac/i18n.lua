-- Reading Log owns its catalogs: do not change KOReader/Bookshelf's gettext
-- domain or process locale. Like KOReader, language changes take effect on restart.
local I = {}
local dir = debug.getinfo(1, "S").source:match("^@(.*)/[^/]*$") or "."

local function loadCatalog(code)
    local chunk = loadfile(dir .. "/locales/" .. code .. ".lua")
    if not chunk then return nil end
    local ok, catalog = pcall(chunk)
    if ok and type(catalog) == "table" then return catalog end
end

local code = "en"
if G_reader_settings and G_reader_settings.readSetting then
    code = G_reader_settings:readSetting("language") or code
end
-- Accept regional variants (it_IT, it-IT, it_IT.UTF-8) without allowing paths.
code = type(code) == "string" and code:match("^([%a][%a%d_-]*)") or "en"
code = (code or "en"):gsub("-", "_"):lower()
local base = code:match("^([^_]+)")
local english = assert(loadCatalog("en"), "Reading Log: missing English locale")
local catalog = loadCatalog(code) or (base ~= code and loadCatalog(base)) or english
I.language = catalog == english and "en" or code
local messages = catalog.messages or {}

function I.gettext(message)
    return messages[message] or message
end

-- %1, %2, ... can be reordered by translators. A function replacement keeps
-- percent signs in metadata and user-entered text literal, and never translates it.
function I.format(message, ...)
    local args = { ... }
    return (I.gettext(message):gsub("%%(%d+)", function(index)
        local value = args[tonumber(index)]
        return value == nil and ("%" .. index) or tostring(value)
    end))
end

-- Catalogs may supply plural forms and a plural_index(n) for languages with
-- more than two forms. Missing forms fall back to the English source.
function I.ngettext(one, many, n)
    local index = catalog.plural_index and catalog.plural_index(n) or (n == 1 and 1 or 2)
    local forms = catalog.plurals and catalog.plurals[one]
    if forms and forms[index] then return forms[index] end
    return I.gettext(n == 1 and one or many)
end

I.thousands_separator = catalog.thousands_separator or english.thousands_separator
I.decimal_separator = catalog.decimal_separator or english.decimal_separator

local function names(key) return catalog[key] or english[key] end
function I.monthLetter(month) return names("month_letters")[month] end
function I.dayLetter(wday) return names("day_letters")[wday] end

-- Format numeric directives with os.date; resolve names by calendar index, not
-- by replacing substrings (which can corrupt e.g. March / Mar or escaped %%).
function I.date(fmt, timestamp)
    -- Preserve Bookshelf's date localization for languages not yet in our
    -- catalogs (as well as the existing English/system-locale behavior).
    if catalog == english then
        local value = os.date(fmt, timestamp)
        local ok, localdate = pcall(require, "lib/bookshelf_localdate")
        if ok and localdate and localdate.localize then
            local localized, result = pcall(localdate.localize, value)
            if localized and type(result) == "string" then return result end
        end
        return value
    end
    local t = os.date("*t", timestamp)
    return (fmt:gsub("%%(.)", function(directive)
        if directive == "%" then return "%" end
        if directive == "A" then return names("days")[t.wday] end
        if directive == "a" then return names("short_days")[t.wday] end
        if directive == "B" then return names("months")[t.month] end
        if directive == "b" or directive == "h" then return names("short_months")[t.month] end
        return os.date("%" .. directive, timestamp)
    end))
end

return I
