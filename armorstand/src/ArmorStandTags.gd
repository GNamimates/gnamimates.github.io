extends VBoxContainer



func _on_InvisibleOption_toggled(toggle):
	ArmorStand.invisible = toggle


func _on_MarkerOption_toggled(toggle):
	ArmorStand.marker = toggle


func _on_SmallOption_toggled(toggle):
	ArmorStand.small = toggle


func _on_ShowArmsOption_toggled(toggle):
	ArmorStand.show_arms = toggle


func _on_NoBasePlateOption_toggled(toggle):
	ArmorStand.no_base_plate = toggle


func _on_InvunerableOption_toggled(toggle):
	ArmorStand.invunerable = toggle


func _on_NoGravityOption_toggled(toggle):
	ArmorStand.no_gravity = toggle


func _on_TagsTextEdit_text_changed():
	var compound = []
	for I in range($TagsTextEdit.get_line_count()):
		compound.append($TagsTextEdit.get_line(I))
	ArmorStand.tags = compound
