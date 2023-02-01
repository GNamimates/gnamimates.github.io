extends Node

export(Vector3) var head
export(Vector3) var body
export(Vector3) var left_leg
export(Vector3) var right_leg
export(Vector3) var left_arm
export(Vector3) var right_arm
export(Array) var tags
export(int) var disabled_slots

export(String) var helmet_item
export(String) var chestplate_item
export(String) var leggings_item
export(String) var boots_item
export(String) var main_hand_item
export(String) var off_hand_item

export(bool) var show_arms setget _show_arms_changed
signal show_arms_changed
func _show_arms_changed(toggle):
	show_arms = toggle
	emit_signal("show_arms_changed")

export(bool) var small setget _small_changed
signal small_changed
func _small_changed(toggle):
	small = toggle
	emit_signal("small_changed")

export(bool) var invisible setget _invisible_changed
signal invisible_changed
func _invisible_changed(toggle):
	invisible = toggle
	emit_signal("invisible_changed")

export(bool) var marker setget _marker_changed
signal marker_changed
func _marker_changed(toggle):
	marker = toggle
	emit_signal("marker_changed")

export(bool) var no_base_plate setget _no_base_plate_changed
signal no_base_plate_changed
func _no_base_plate_changed(toggle):
	no_base_plate = toggle
	emit_signal("no_base_plate_changed")

export(bool) var no_gravity
export(bool) var invunerable
