extends Tabs

func _ready():
	History.connect("new_action",self,"_new_history_action")
	History.connect("undo",self,"_history_undo")
	History.connect("redo",self,"_history_redo")

onready var current = $VBoxContainer/ScrollContainer/VBoxContainer/current
onready var future = $VBoxContainer/ScrollContainer/VBoxContainer/future

func _new_history_action(object,path,before,after,message):
	var button = Button.new()
	button.text = message
	button.connect("pressed",self,"_time_travel",[History.timeline.size()-1])
	current.add_child(button)
	for child in future.get_children():
		child.queue_free()

func _history_undo():
	var childs = current.get_children()
	var rip = childs[childs.size()-1]
	current.remove_child(rip)
	future.add_child(rip)
	future.move_child(rip,0)

func _history_redo():
	var childs = future.get_children()
	var rip = childs[0]
	future.remove_child(rip)
	current.add_child(rip)

func _time_travel(time):
	var offset = History.timeline.size()-time-1
	if offset > 0:
		for I in range(offset):
			History.undo()
	else:
		for I in range(-offset):
			History.redo()


func _on_UndoButton_pressed():
	History.undo()


func _on_RedoButton_pressed():
	History.redo()
