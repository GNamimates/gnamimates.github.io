tool
extends Node

var gizmo_highlighted = false
var mouse_in_viewport = false
var snap = 0

var version = "0.2.2"

var selected = null
var last_selected = null
signal selected_changed
signal selected_rotation_changed
func set_selected(s):
	selected = s
	if s:
		last_selected = s
	emit_signal("selected_changed",selected)

func snap(value):
	if snap == 0:
		return value
	else:
		snap = deg2rad(snap)
		var result =  floor(value/snap+0.5)*snap
		snap = rad2deg(snap)
		return result

func rotation(rotation):
	var t = Transform.IDENTITY
	t = t.rotated(Vector3(1, 0, 0), rotation.x)
	t = t.rotated(Vector3(0, -1, 0), rotation.y)
	t = t.rotated(Vector3(0, 0, -1), rotation.z)
	return t

func vec3toNBTfloat3(vec):
	return [floor(vec.x*10)/10,floor(vec.y*10)/10,floor(vec.z*10)/10]
