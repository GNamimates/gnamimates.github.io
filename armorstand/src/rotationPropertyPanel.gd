extends Tabs

func _ready():
	Global.connect("selected_rotation_changed",self,"_selected_rotation_changed")
	Global.connect("selected_changed",self,"_selected_changed")

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
		tween.tween_property(parent,"margin_left",-352.0,transition_duration)
		tween.tween_property(parent,"margin_right",-240.0,transition_duration)
	else:
		var tween = get_tree().create_tween().set_parallel(true).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
		tween.tween_property(parent,"margin_left",-228.0,transition_duration)
		tween.tween_property(parent,"margin_right",-116.0,transition_duration)

func _selected_rotation_changed(source):
	if source != self:
		var rot = Global.selected.true_rotation
		$VBoxContainer/X/xval.value = rad2deg(rot.x)
		$VBoxContainer/Y/yval.value = rad2deg(rot.y)
		$VBoxContainer/Z/zval.value = rad2deg(rot.z)

func _on_xval_value_changed(value):
	if Global.last_selected:
		Global.last_selected.true_rotation.x = deg2rad(value)
		Global.emit_signal("selected_rotation_changed",self)


func _on_yval_value_changed(value):
	if Global.last_selected:
		Global.last_selected.true_rotation.y = deg2rad(value)
		Global.emit_signal("selected_rotation_changed",self)


func _on_zval_value_changed(value):
	if Global.last_selected:
		Global.last_selected.true_rotation.z = deg2rad(value)
		Global.emit_signal("selected_rotation_changed",self)
