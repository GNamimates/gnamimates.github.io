extends Node

var highlight_material = preload("res://material/highlighted.tres")
var selected_material = preload("res://material/selected.tres")
var selected = null

var last_highlighted = null
var current_highlighted = null

func _ready():
	ArmorStand.connect("no_base_plate_changed",self,"_baseplate_changed")
	ArmorStand.connect("small_changed",self,"_small_changed")
	ArmorStand.connect("show_arms_changed",self,"_arms_changed")

func _input(event):
	if event is InputEventMouseMotion:# Hightlighter
		var camera = get_viewport().get_camera()
		var from = camera.project_ray_origin(event.position)
		var to = camera.project_ray_normal(event.position) * 100
		var direct_state = PhysicsServer.space_get_direct_state(camera.get_world().get_space())
		var hit = direct_state.intersect_ray(from,to,[camera])
		
		last_highlighted = current_highlighted
		if hit.has("collider"):
			current_highlighted = hit.collider
		else:
			current_highlighted = null
		if current_highlighted != last_highlighted:
			if current_highlighted:
				for child in current_highlighted.get_children():
					if child is MeshInstance:
						child.material_overlay = highlight_material
			if last_highlighted:
				for child in last_highlighted.get_children():
					if child is MeshInstance:
						child.material_overlay = null
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and not event.is_echo():
			if not Global.gizmo_highlighted and Global.mouse_in_viewport:
				Global.set_selected(current_highlighted)


# Toggles the lighting
func _on_LightingToggleButton_toggled(button_pressed):
	$GlobalLight.visible = !button_pressed
	$OrbitCamera/LocalLight.visible = button_pressed


func _on_ViewportArea_mouse_exited():
	Global.mouse_in_viewport = false


func _on_ViewportArea_mouse_entered():
	Global.mouse_in_viewport = true


func _on_SnapToggleButton_toggled(button_pressed):
	if button_pressed:
		Global.snap = $CanvasLayer/SnapToggleButton/SnapStep.value
	else:
		Global.snap = 0


func _on_SnapStep_value_changed(value):
	Global.snap = value

func _baseplate_changed():
	$armor_stand/plate.visible = !ArmorStand.no_base_plate

func _small_changed():
	if ArmorStand.small:
		$armor_stand/baseplate/Mannequin.scale = Vector3(0.6,0.6,0.6)
	else:
		$armor_stand/baseplate/Mannequin.scale = Vector3.ONE

func _arms_changed():
	$armor_stand/baseplate/Mannequin/right_arm_bone.visible = ArmorStand.show_arms
	$armor_stand/baseplate/Mannequin/right_arm_bone/CollisionShape.disabled = !ArmorStand.show_arms
	$armor_stand/baseplate/Mannequin/left_arm_bone.visible = ArmorStand.show_arms
	$armor_stand/baseplate/Mannequin/left_arm_bone/CollisionShape.disabled = !ArmorStand.show_arms
