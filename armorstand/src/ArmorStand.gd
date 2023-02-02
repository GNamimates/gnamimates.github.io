extends Node

signal property_changed

export(Vector3) var head setget _head_changed
func _head_changed(value):
	head = value
	emit_signal("property_changed")

export(Vector3) var body setget _body_changed
func _body_changed(value):
	body = value
	emit_signal("property_changed")

export(Vector3) var left_leg setget _head_changed
func _left_leg_changed(value):
	left_leg = value
	emit_signal("property_changed")

export(Vector3) var right_leg setget _right_leg_changed
func _right_leg_changed(value):
	right_leg = value
	emit_signal("property_changed")

export(Vector3) var left_arm setget _left_arm_changed
func _left_arm_changed(value):
	left_arm = value
	emit_signal("property_changed")

export(Vector3) var right_arm setget _right_arm_changed
func _right_arm_changed(value):
	right_arm = value
	emit_signal("property_changed")

export(float) var rotation setget _rotation_changed
func _rotation_changed(value):
	rotation = value
	emit_signal("property_changed")

export(Array) var tags setget _tags_changed
func _tags_changed(value):
	tags = value
	emit_signal("property_changed")

export(int) var disabled_slots setget _disabled_slots_changed
func _disabled_slots_changed(value):
	disabled_slots = value
	emit_signal("property_changed")

export(String) var helmet_item setget _helmet_item_changed
func _helmet_item_changed(value):
	helmet_item = value
	emit_signal("property_changed")

export(int) var helmet_count = 1 setget _helmet_count_changed
func _helmet_count_changed(count):
	helmet_count = count
	emit_signal("property_changed")

export(String) var chestplate_item setget _chestplate_item_changed
func _chestplate_item_changed(value):
	chestplate_item = value
	emit_signal("property_changed")

export(int) var chestplate_count = 1 setget _chestplate_count_changed
func _chestplate_count_changed(count):
	chestplate_count = count
	emit_signal("property_changed")

export(String) var leggings_item setget _leggings_item_changed
func _leggings_item_changed(value):
	leggings_item = value
	emit_signal("property_changed")

export(int) var leggings_count = 1 setget _leggings_count_changed
func _leggings_count_changed(count):
	leggings_count = count
	emit_signal("property_changed")

export(String) var boots_item setget _boots_item_changed
func _boots_item_changed(value):
	boots_item = value
	emit_signal("property_changed")

export(int) var boots_count = 1 setget _boots_count_changed
func _boots_count_changed(count):
	boots_count = count
	emit_signal("property_changed")

export(String) var main_hand_item setget _main_hand_item_changed
func _main_hand_item_changed(value):
	main_hand_item = value
	emit_signal("property_changed")

export(int) var main_hand_count = 1 setget _main_hand_count_changed
func _main_hand_count_changed(count):
	main_hand_count = count
	emit_signal("property_changed")

export(String) var off_hand_item setget _off_hand_item_changed
func _off_hand_item_changed(value):
	off_hand_item = value
	emit_signal("property_changed")

export(int) var off_hand_count = 1 setget _off_hand_count_changed
func _off_hand_count_changed(count):
	off_hand_count = count
	emit_signal("property_changed")


export(bool) var show_arms = true setget _show_arms_changed
signal show_arms_changed
func _show_arms_changed(toggle):
	show_arms = toggle
	emit_signal("show_arms_changed")
	emit_signal("property_changed")

export(bool) var small setget _small_changed
signal small_changed
func _small_changed(toggle):
	small = toggle
	emit_signal("small_changed")
	emit_signal("property_changed")

export(bool) var invisible setget _invisible_changed
signal invisible_changed
func _invisible_changed(toggle):
	invisible = toggle
	emit_signal("invisible_changed")
	emit_signal("property_changed")

export(bool) var marker setget _marker_changed
signal marker_changed
func _marker_changed(toggle):
	marker = toggle
	emit_signal("marker_changed")
	emit_signal("property_changed")

export(bool) var no_base_plate setget _no_base_plate_changed
signal no_base_plate_changed
func _no_base_plate_changed(toggle):
	no_base_plate = toggle
	emit_signal("no_base_plate_changed")
	emit_signal("property_changed")

export(bool) var no_gravity setget _no_gravity_changed
signal no_gravity_changed
func _no_gravity_changed(toggle):
	no_gravity = toggle
	emit_signal("property_changed")

export(bool) var invunerable setget _invunerable_changed
signal invunerable_changed
func _invunerable_changed(toggle):
	invunerable = toggle
	emit_signal("property_changed")

export(bool) var raw_name setget _raw_name_changed
signal raw_name_changed
func _raw_name_changed(toggle):
	raw_name = toggle
	emit_signal("property_changed")

export(bool) var custom_name_visible setget _custom_name_visible_changed
signal custom_name_visible_changed
func _custom_name_visible_changed(toggle):
	custom_name_visible = toggle
	emit_signal("property_changed")


export(String) var custom_name setget _custom_name_changed
func _custom_name_changed(value):
	custom_name = value
	emit_signal("property_changed")


func getNBTString():
	var compose = {}
	if show_arms:
		compose.ShowArms = 1
	if no_base_plate:
		compose.NoBasePlate = 1
	if disabled_slots != 0:
		compose.DisabledSlots = disabled_slots
	if small:
		compose.Small = 1
	if no_gravity:
		compose.NoGravity = 1
	if invisible:
		compose.Invisible = 1
	if rotation != 0:
		compose.Rotation = [rotation]
	if marker:
		compose.Marker = 1
	if invunerable:
		compose.Invunerable = 1
	if !tags.empty():
		compose.Tags = tags
	var Pose = {}
	if head != Vector3(0,0,0):
		Pose.Head = Global.vec3toNBTfloat3(head)
	if body != Vector3(0,0,0):
		Pose.Body = Global.vec3toNBTfloat3(body)
	if left_arm != Vector3(0,0,0):
		Pose.LeftArm = Global.vec3toNBTfloat3(left_arm)
	if right_arm != Vector3(0,0,0):
		Pose.RightArm = Global.vec3toNBTfloat3(right_arm)
	if left_leg != Vector3(0,0,0):
		Pose.LeftLeg = Global.vec3toNBTfloat3(left_leg)
	if right_leg != Vector3(0,0,0):
		Pose.RightLeg = Global.vec3toNBTfloat3(right_leg)
	if !Pose.empty():
		compose.Pose = Pose
	if custom_name.length() != 0:
		if raw_name:
			compose.CustomName = str("\'",custom_name,"\'")
		else:
			compose.CustomName = str('\'{"text":"',custom_name,'"}\'')
		if custom_name_visible:
			compose.CustomNameVisible = 1
	var armor_items = [{},{},{},{}]
	var armor_has_something = false
	if helmet_item != "":
		armor_items[0].id = '"'+helmet_item+'"'
		armor_items[0].Count = helmet_count
		armor_has_something = true
	if chestplate_item != "":
		armor_items[1].id = '"'+chestplate_item+'"'
		armor_items[1].Count = chestplate_count
		armor_has_something = true
	if leggings_item != "":
		armor_items[2].id = '"'+leggings_item+'"'
		armor_items[2].Count = leggings_count
		armor_has_something = true
	if boots_item != "":
		armor_items[3].id = '"'+boots_item+'"'
		armor_items[3].Count = boots_count
		armor_has_something = true
	if armor_has_something:
		compose.ArmorItems = armor_items
	return "/summon armor_stand ~ ~ ~ "+str(compose).replace(", ",",")
