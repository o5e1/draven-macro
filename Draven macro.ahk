#NoEnv
#SingleInstance
SendMode Input
SetWorkingDir %A_ScriptDir%
global isRunning := false
global keybind := ""
global oldKeybind := ""
global delay := 10
global waitingForKeybind := false

Gui, Color, FFFFFF 
Gui, Font, s8, Arial

; Keybind section
Gui, Add, Text, c1A1A1A x10 y10, Keybind for Macro:
Gui, Add, Text, vKeybindDisplay c1A1A1A w120 h20 x+10 yp+0, Not Set
Gui, Add, Button, gSetKeybind x+10 yp+0 w100 h25, Assign Keybind

; Macro speed section
Gui, Add, Text, c1A1A1A x+10 yp+0, Delay per interval:
Gui, Add, Edit, vDelayEdit w50 h20 x+10 yp+0, %delay%
Gui, Add, Button, gSaveSettings x+10 yp+0 w100 h25, Apply Settings

; Simulated line
Gui, Add, Text, x10 y+40 w+260 h1 c1A1A1A BackgroundFFFFFF

Gui, Font, s8, Arial
Gui, Add, Text, c1A1A1A x10 y+50, Draven.cc macro @o5e1 

Gui, Show,, Draven macro (Updated)
return

SetKeybind:
if (oldKeybind != "")
{
    Hotkey, %oldKeybind%, ToggleMacro, Off
}
GuiControl,, KeybindDisplay, Press a Key..
Input, keybind, L1 T2
if (ErrorLevel = "Timeout")
{
    GuiControl,, KeybindDisplay, Not Set
    return
}
StringUpper, keybind, keybind
GuiControl,, KeybindDisplay, %keybind%
Hotkey, ~*%keybind%, ToggleMacro
oldKeybind := keybind
GuiControl,, KeybindDisplay, %keybind%
return

SaveSettings:
GuiControlGet, keybind, , KeybindDisplay
GuiControlGet, delay, , DelayEdit
delay := (delay < 1) ? 1 : delay
return

ToggleMacro:
isRunning := !isRunning
if isRunning {
    SetTimer, RunMacro, % delay
} else {
    SetTimer, RunMacro, Off
}
return

RunMacro:
Send, {Blind}{WheelUp}
Sleep, %delay%
Send, {Blind}{WheelDown}
Sleep, %delay%
return

GuiClose:
ExitApp
