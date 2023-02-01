extends Spatial

const sensitivity = 0.4
const pan_sensitivity = 0.00112

func _input(event):
	if Global.mouse_in_viewport:
		if event is InputEventMouseMotion:
			if Input.is_action_pressed("orbit"):
				if Input.is_action_pressed("pan"):
					translation += global_transform.basis.y*event.relative.y*pan_sensitivity*$Camera.translation.z
					translation += global_transform.basis.x*-event.relative.x*pan_sensitivity*$Camera.translation.z
				else:
					rotation_degrees.y -= event.relative.x * sensitivity
					rotation_degrees.x = clamp(rotation_degrees.x-event.relative.y * sensitivity,-90,90)
		if event is InputEventMouseButton:
			if Input.is_action_just_released("zoom_in"):
				$Camera.translation.z *= 0.9
			if Input.is_action_just_released("zoom_out"):
				$Camera.translation.z *= 1.1
