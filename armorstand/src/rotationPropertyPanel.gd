extends Tabs

func _ready():
	Global.connect("selected_rotation_changed",self,"_selected_rotation_changed")
	Global.connect("selected_changed",self,"_selected_changed")
	History.connect("undo",self,"reload_values")
	History.connect("redo",self,"reload_values")

var last_true_rotation = null
onready var parent = get_parent()
const transition_duration = 0.25

func _selected_changed(selected):
	if selected:
		if selected.y_only:
			$VBoxContainer/X/xval.visible = false
			$VBoxContainer/Z/zval.visible = false
		else:
			$VBoxContainer/X/xval.visible = true
			$VBoxContainer/Z/zval.visible = true
		$VBoxContainer/X/xval.value = rad2deg(Global.last_selected.true_rotation.x)
		$VBoxContainer/Y/yval.value = rad2deg(Global.last_selected.true_rotation.y)
		$VBoxContainer/Z/zval.value = rad2deg(Global.last_selected.true_rotation.z)
		var tween = get_tree().create_tween().set_parallel(true).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tween.tween_property(parent,"margin_left",-360.0,transition_duration)
		tween.tween_property(parent,"margin_right",-240.0,transition_duration)
	else:
		var tween = get_tree().create_tween().set_parallel(true).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
		tween.tween_property(parent,"margin_left",-228.0,transition_duration)
		tween.tween_property(parent,"margin_right",-116.0,transition_duration)


func _selected_rotation_changed(source):
	if source != self:
		last_true_rotation = Global.last_selected.true_rotation
		var rot = Global.selected.true_rotation
		$VBoxContainer/X/xval.value = rad2deg(rot.x)
		$VBoxContainer/Y/yval.value = rad2deg(rot.y)
		$VBoxContainer/Z/zval.value = rad2deg(rot.z)

func reload_values():
	_selected_changed(Global.selected)


func _on_xval_value_changed(value):
	if Global.last_selected:
		last_true_rotation = Global.last_selected.true_rotation
		Global.last_selected.true_rotation.x = deg2rad(value)
		Global.emit_signal("selected_rotation_changed",self)


func _on_yval_value_changed(value):
	if Global.last_selected:
		last_true_rotation = Global.last_selected.true_rotation
		Global.last_selected.true_rotation.y = deg2rad(value)
		Global.emit_signal("selected_rotation_changed",self)


func _on_zval_value_changed(value):
	if Global.last_selected:
		Global.last_selected.true_rotation.z = deg2rad(value)
		Global.emit_signal("selected_rotation_changed",self)


var xwas_pressed = false
func _on_xval_gui_input(event):
	if event is InputEventMouseButton:
		if xwas_pressed:
			History.add_action(Global.last_selected,"true_rotation",last_true_rotation,Global.last_selected.true_rotation,str("Rotated ",Global.last_selected.name.replace("_"," ")))
			last_true_rotation = Global.last_selected.true_rotation
		xwas_pressed = event.pressed

var ywas_pressed = false
func _on_yval_gui_input(event):
	if event is InputEventMouseButton:
		if ywas_pressed:
			History.add_action(Global.last_selected,"true_rotation",last_true_rotation,Global.last_selected.true_rotation,str("Rotated ",Global.last_selected.name.replace("_"," ")))
			last_true_rotation = Global.last_selected.true_rotation
		ywas_pressed = event.pressed

var zwas_pressed = false
func _on_zval_gui_input(event):
	if event is InputEventMouseButton:
		if zwas_pressed:
			History.add_action(Global.last_selected,"true_rotation",last_true_rotation,Global.last_selected.true_rotation,str("Rotated ",Global.last_selected.name.replace("_"," ")))
			last_true_rotation = Global.last_selected.true_rotation
		zwas_pressed = event.pressed
