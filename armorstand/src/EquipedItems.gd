extends VBoxContainer



func _on_HelmetItem_text_changed(id):
	ArmorStand.helmet_item = id


func _on_ChestplateItem_text_changed(id):
	ArmorStand.chestplate_item = id


func _on_LeggingsItem_text_changed(id):
	ArmorStand.leggings_item = id


func _on_BootsItem_text_changed(id):
	ArmorStand.boots_item = id


func _on_MainHandItem_text_changed(id):
	ArmorStand.main_hand_item = id


func _on_OffHandItem_text_changed(id):
	ArmorStand.off_hand_item = id


func _on_HelmetCount_value_changed(value):
	ArmorStand.helmet_count = value


func _on_ChestplateCount_value_changed(value):
	ArmorStand.chestplate_count = value


func _on_LeggingsCount_value_changed(value):
	ArmorStand.leggings_count = value


func _on_BootsCount_value_changed(value):
	ArmorStand.boots_count = value


func _on_MainHandCount_value_changed(value):
	ArmorStand.main_hand_count = value


func _on_OffHandCount_value_changed(value):
	ArmorStand.off_hand_count = value
