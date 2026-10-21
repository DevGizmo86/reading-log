# Translating Reading Log

Reading Log follows KOReader's interface language. English and Italian are
included; selecting **Italiano** in KOReader and restarting also translates
the cards, dashboard tabs and module settings. There is no separate language
setting. Install the entire `micromodules/almanac/` folder, including `locales/`.

The translation layer is private to Reading Log. It does not change KOReader's
or Bookshelf's gettext domain or the system locale. No additional package,
network connection or compilation step is required on the reader.

## Add a language

1. Copy `micromodules/almanac/locales/it.lua` to `<language>.lua` in that folder
   (for example, `fr.lua`). Keep the English message keys and translate their
   values, together with the day/month names and initials at the top.
2. Set `thousands_separator` and `decimal_separator` for that language.
3. Adjust `plurals` and, if needed, add a `plural_index(n)` function returning
   the 1-based form index. Without it, 1 is singular and all other counts use
   the second form. Plural entries are keyed by the English singular message.
4. Run `lua tests/i18n_spec.lua` (or `luajit tests/i18n_spec.lua`) from the
   repository root, then check the cards on KOReader in the new language,
   including narrow cards, module previews and the Mini dashboard.

Language codes are case-insensitive, with `-` normalized to `_`. The loader
tries the full code, then the base language: `it_IT` and `it-IT` both use
`it.lua`. A region can have its own file, such as `pt_br.lua`. Missing catalogs
or individual messages fall back to English. The English catalog holds date
and number data; English messages remain readable directly in the source.

## Mark messages in code

Each component uses `local T = A._`. Wrap **built-in interface strings** with
`T("English message")`. Do not translate IDs, action keys, file names, saved
values, book metadata, collection names or text entered by the reader.
In particular, the `Hardcopy`, `bookclub <year>` and TBR collection lookups
keep their existing names; only the displayed labels are translated.

For variable sentences, use complete messages and numbered placeholders:

```lua
A.tr("%1's books", A.date("%B", when))
```

Translators can reorder `%1`, `%2`, etc. Preserve every placeholder. The
arguments are inserted literally, including percent signs, and are never
translated. Some existing captions are assembled from short fragments;
leading/trailing spaces in those catalog entries must be preserved.

For counts, `A.plural(n, "book", "books")` selects and translates the unit.
For labels without the numeric value use
`A.i18n.ngettext("singular source", "plural source", n)`. Catalog `plurals`
can provide additional forms without changing callers.

Use `A.date`, `A.thousands` and `A.decimal` for interface formatting. Keep
machine-readable dates, SQL, settings keys, and statistics unchanged.
KOReader requests a restart after changing language; Reading Log's static
module definitions are rebuilt on that restart too.

## Validation

The standalone test loads both language modes, checks locale variants,
English fallback, dates and calendar initials, numbers, plurals, placeholder
preservation, Italian source-message coverage, and stable IDs/user labels.
It does not emulate KOReader's fonts or an e-ink display. Before merging a
new translation, inspect the actual layout on a reader or in the emulator.
