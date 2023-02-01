tool
extends StaticBody
class_name ArmorStandSegment

export(Vector3) var true_rotation setget set_true_rotation
export(bool) var y_only
var ready = false

func set_true_rotation(true_rot):
	true_rotation = true_rot
	if ready:
		transform.basis = Global.rotation(true_rot).basis

func _ready():
	ready = true
	set_true_rotation(true_rotation)
