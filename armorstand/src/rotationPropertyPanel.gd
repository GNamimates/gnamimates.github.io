extends Tabs

func _ready():
	Global.connect("selected_rotation_changed",self,"_selected_rotation_changed")
	Global.connect("selected_changed",self,"_selected_changed")

func _selected_changed(selected):
	if selected:
		if selected.y_only:
			$VBoxContainer/X/xval.visible = false
			$VBoxContainer/Z/zval.visible = false
		else:
			$VBoxContainer/X/xval.visible = true
			$VBoxContainer/Z/zval.visible = true
		get_parent().visible = true
	else:
		get_parent().visible = false

func _selected_rotation_changed(source):
	if source != self:
		var rot = Global.selected.true_rotation
		$VBoxContainer/X/xval.value = rad2deg(rot.x)
		$VBoxContainer/Y/yval.value = rad2deg(rot.y)
		$VBoxContainer/Z/zval.value = rad2deg(rot.z)



func _on_xval_value_changed(value):
	Global.last_selected.true_rotation.x = deg2rad(value)
	Global.emit_signal("selected_rotation_changed",self)


func _on_yval_value_changed(value):
	Global.last_selected.true_rotation.y = deg2rad(value)
	Global.emit_signal("selected_rotation_changed",self)


func _on_zval_value_changed(value):
	Global.last_selected.true_rotation.z = deg2rad(value)
	Global.emit_signal("selected_rotation_changed",self)
