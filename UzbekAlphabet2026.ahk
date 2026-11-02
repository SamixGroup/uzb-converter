#Requires AutoHotkey v2.0
#SingleInstance Force
; Uzbek Latin alphabet: old (1995) -> new (2026) auto-replace
; Source rules: https://alfavit.uz/alphabet
;
;   oʻ -> ö   gʻ -> ğ   sh -> ş   ch -> ç      (capital forms too)
;   o‘ o’ o' o` oʻ oʼ are all treated as the same mark.
;
; Ctrl+Alt+U : turn auto-replace on/off
; Ctrl+Alt+K : convert the currently selected text

enabled := true

A_TrayMenu.Delete()
A_TrayMenu.Add("Enabled (Ctrl+Alt+U)", ToggleEnabled)
A_TrayMenu.Check("Enabled (Ctrl+Alt+U)")
A_TrayMenu.Add("Convert selection (Ctrl+Alt+K)", (*) => ConvertSelection())
A_TrayMenu.Add()
A_TrayMenu.Add("Exit", (*) => ExitApp())
A_IconTip := "Uzbek alphabet 2026 - ON"

; ---- Live replacement while typing -------------------------------------
HotIf (*) => enabled

aps := ["'", "‘", "’", "ʻ", "ʼ", "``", "´"]
for ap in aps {
    for pair in [["o", "ö"], ["O", "Ö"], ["g", "ğ"], ["G", "Ğ"]]
        Hotstring(":*?C:" pair[1] ap, pair[2])
}
for pair in [["sh", "ş"], ["Sh", "Ş"], ["SH", "Ş"], ["ch", "ç"], ["Ch", "Ç"], ["CH", "Ç"]]
    Hotstring(":*?C:" pair[1], pair[2])

HotIf  ; reset context

; ---- Hotkeys ---------------------------------------------------------------
^!u:: ToggleEnabled()
^!k:: ConvertSelection()

ToggleEnabled(*) {
    global enabled
    enabled := !enabled
    if enabled
        A_TrayMenu.Check("Enabled (Ctrl+Alt+U)")
    else
        A_TrayMenu.Uncheck("Enabled (Ctrl+Alt+U)")
    A_IconTip := "Uzbek alphabet 2026 - " (enabled ? "ON" : "OFF")
    TrayTip(enabled ? "Auto-replace ON" : "Auto-replace OFF", "Uzbek alphabet 2026")
}

ConvertSelection() {
    saved := ClipboardAll()
    A_Clipboard := ""
    Send("^c")
    if !ClipWait(0.7) {
        A_Clipboard := saved
        return
    }
    A_Clipboard := ConvertText(A_Clipboard)
    Send("^v")
    Sleep(200)
    A_Clipboard := saved
}

ConvertText(t) {
    aps := ["'", "‘", "’", "ʻ", "ʼ", "``", "´"]
    for ap in aps {
        t := StrReplace(t, "O" ap, "Ö", true)
        t := StrReplace(t, "o" ap, "ö", true)
        t := StrReplace(t, "G" ap, "Ğ", true)
        t := StrReplace(t, "g" ap, "ğ", true)
    }
    for pair in [["SH", "Ş"], ["Sh", "Ş"], ["sh", "ş"], ["CH", "Ç"], ["Ch", "Ç"], ["ch", "ç"]]
        t := StrReplace(t, pair[1], pair[2], true)
    return t
}
