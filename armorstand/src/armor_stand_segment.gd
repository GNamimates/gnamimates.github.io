tool
extends StaticBody
class_name ArmorStandSegment

export(Vector3) var true_rotation setget set_true_rotation
export(String) var segment_name
export(bool) var y_only
var ready = false

func set_true_rotation(true_rot):
	true_rotation = true_rot
	if ready:
		transform.basis = Global.rotation(true_rot).basis
		if y_only:
			ArmorStand.set(segment_name,floor(rad2deg(true_rot.y*10))/10)
		else:
			ArmorStand.set(segment_name,Vector3(
				floor(0.5+(rad2deg(true_rot.x))*10)/10,
				floor(0.5+(rad2deg(true_rot.y))*10)/10,
				floor(0.5+(rad2deg(true_rot.z))*10)/10)
				)

func _ready():
	ready = true
	set_true_rotation(true_rotation)
