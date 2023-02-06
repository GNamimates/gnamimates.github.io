extends Node

var timeline = []
var future = []

signal new_action

func new_action():
	pass

func add_action(object,path,before,after,message):
	timeline.append([object,path,before,after,message])
	future.clear() # lazy implementation, add future recovery
	emit_signal("new_action",object,path,before,after,message)


signal undo
func undo():
	if !timeline.empty():
		var i = timeline.size()-1
		var t = timeline[i]
		t[0].set(t[1],t[2])
		future.append(timeline[i])
		timeline.remove(i)
		emit_signal("undo")

signal redo
func redo():
	if !future.empty():
		var i = future.size()-1
		timeline.append(future[i])
		future.remove(i)
		if !timeline.empty():
			var t = timeline[timeline.size()-1]
			t[0].set(t[1],t[3])
			emit_signal("redo")
