# Small editor based on libui
#
# Compile: `nim c -d:useLibUiDll uiedit.nim`
# You need a copy of Meson's libui library, i.e.:
# cp ~/Dev/C/libui/build/meson-out/libui.A.dylib libui.dylib


import asyncdispatch
import notifications/macosx
import ui

proc clearText(w: Window, m: MultilineEntry) =
  m.text = ""

proc openFile(win: Window, multiline: MultilineEntry, working_file: var string) =
  working_file = ui.openFile(win)
  if working_file.len != 0:
    let f = open(working_file, fmRead)
    multiline.text = f.readAll()
    f.close
    var notif_center = newNotificationCenter()
    asyncCheck notif_center.show("File loaded", "Filename: " & working_file)

proc saveFile(win: Window, multiline: MultilineEntry, working_file: var string) =
  if working_file.len != 0:
    let f = open(working_file, fmWrite)
    f.write (multiline.text)
    f.close
    var notif_center = newNotificationCenter()
    asyncCheck notif_center.show("File saved", "Filename: " & working_file)

proc main*() =
  
  var editor = newMultilineEntry()
  var working_file: string
  var mainwin: Window

  var menu = newMenu("File")
  menu.addItem("Open", proc() = openFile(mainwin, editor, working_file))
  menu.addItem("Save", proc() = saveFile(mainwin, editor, working_file))

  menu.addSeparator()
  menu.addQuitItem(proc(): bool {.closure.} = return true)

  mainwin = newWindow("Tiny Nim Editor", 800, 600, true)
  mainwin.margined = true
  mainwin.onClosing = (proc (): bool = return true)

  let box = newVerticalBox(true)
  mainwin.setChild(box)

  var group = newGroup("Actions", true)
  box.add(group, false)
  var inner = newVerticalBox(true)
  group.child = inner

  box.add editor

  var hbox = newHorizontalBox()
  hbox.add newButton("Clear", proc() = clearText(mainwin, editor))
  inner.add hbox

  show(mainwin)
  mainLoop()

init()
main()


