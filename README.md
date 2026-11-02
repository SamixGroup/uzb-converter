# Uzbek Latin Alphabet Converter (1995 → 2026)

Converts Uzbek text from the old (1995) Latin alphabet to the new 2026 alphabet, using the rules on [alfavit.uz/alphabet](https://alfavit.uz/alphabet).

| Old (1995) | New (2026) | Example |
|---|---|---|
| Oʻ oʻ | Ö ö | koʻl → köl |
| Gʻ gʻ | Ğ ğ | gʻalaba → ğalaba |
| Sh sh | Ş ş | shahar → şahar |
| Ch ch | Ç ç | choy → çoy |

All apostrophe-like marks after o / g (`ʻ ʼ ‘ ’ ' `` ` ```) are treated the same, so `O‘` and `o’` both give `Ö` / `ö`.

## Contents

- `index.html`: standalone web converter (open it in any browser, no build step). Includes a swap button for new → old.
- `UzbekAlphabet2026.ahk`: Windows tray tool (AutoHotkey v2) that replaces these letters as you type system-wide.
  - `Ctrl+Alt+U` toggles auto-replace on/off
  - `Ctrl+Alt+K` converts the selected text
  - Not tested on Windows by the author; switch it off when typing English (`shop` would become `şop`).
  - To get an `.exe`, right-click the script → "Compile script".

## Notes

- `ng` is no longer a separate letter but is still written `ng`.
- A split like `s'h` or `c'h` is not read as sh / ch.

Made by Sam. (tg: no_arrogance)
