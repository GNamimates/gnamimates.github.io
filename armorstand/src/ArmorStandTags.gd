extends VBoxContainer



func _on_InvisibleOption_toggled(toggle):
	History.add_action($InvisibleOption,"pressed",not toggle,toggle,"Toggled Invisible")
	ArmorStand.invisible = toggle


func _on_MarkerOption_toggled(toggle):
	History.add_action($MarkerOption,"pressed",not toggle,toggle,"Toggled Marker")
	ArmorStand.marker = toggle


func _on_SmallOption_toggled(toggle):
	History.add_action($SmallOption,"pressed",not toggle,toggle,"Toggled Size")
	ArmorStand.small = toggle


func _on_ShowArmsOption_toggled(toggle):
	History.add_action($ShowArmsOption,"pressed",not toggle,toggle,"Toggled Arms")
	ArmorStand.show_arms = toggle


func _on_NoBasePlateOption_toggled(toggle):
	History.add_action($NoBasePlateOption,"pressed",not toggle,toggle,"Toggled Baseplate")
	ArmorStand.no_base_plate = toggle


func _on_InvunerableOption_toggled(toggle):
	History.add_action($InvisibleOption,"pressed",not toggle,toggle,"Toggled Invunerability")
	ArmorStand.invunerable = toggle


func _on_NoGravityOption_toggled(toggle):
	History.add_action($NoGravityOption,"pressed",not toggle,toggle,"Toggled Gravity")
	ArmorStand.no_gravity = toggle


func _on_TagsTextEdit_text_changed():
	var compound = []
	for I in range($TagsTextEdit.get_line_count()):
		compound.append($TagsTextEdit.get_line(I))
	ArmorStand.tags = compound
