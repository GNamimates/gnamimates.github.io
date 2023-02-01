extends Spatial

enum AXIS {x,y,z}

var axis_selected = AXIS.x
var axis_highlighting = null
var true_rot = Vector3()
var true_rot_raw = Vector3()
var local_last = null

const ring_low = 0.9
const ring_high = 1.1
var scl = 1
var material_x = preload("res://material/red.tres")
var material_y = preload("res://material/green.tres")
var material_z = preload("res://material/blue.tres")

var intersection_x = null
var intersection_y = null
var intersection_z = null

var dragging = false
var last_intersection_pos = null

func _ready():
# warning-ignore:return_value_discarded
	Global.connect("selected_changed",self,"_selected_changed")
	Global.connect("selected_rotation_changed",self,"_selected_rotation_changed")

func _selected_rotation_changed(source):
	if source != self and Global.selected and !dragging:
		apply_selected(Global.selected)

func apply_selected(node):
	global_transform.origin = node.global_transform.origin
	$Z/Y/X.rotation.x = node.true_rotation.x
	$Z/Y.rotation.y = -node.true_rotation.y
	$Z.rotation.z = -node.true_rotation.z
	true_rot_raw = node.true_rotation

func _selected_changed(node):
	if node:
		apply_selected(node)
		visible = true
		global_transform.basis = Global.selected.get_parent().global_transform.basis
		global_transform.origin = global_transform.origin
		if Global.selected.y_only:
			$Z/Y/X/ring.visible = false
			$Z/ring.visible = false
		else:
			$Z/Y/X/ring.visible = true
			$Z/ring.visible = true
	else:
		visible = false

func _process(_delta):
	var size = get_viewport().size
	scl = size.x/size.y
	scl *= global_transform.origin.distance_to(get_viewport().get_camera().global_transform.origin)
	scl *= 0.1
	scale = Vector3(scl,scl,scl)

func _input(event):
	if Global.selected and visible:
		if event is InputEventMouseMotion:
			var camera = get_viewport().get_camera()
			var from = camera.project_ray_origin(event.position)
			var to = camera.project_ray_normal(event.position)
			var direct_state = PhysicsServer.space_get_direct_state(camera.get_world().get_space())
			var hit = direct_state.intersect_ray(from,to*100,[camera])
			from -= global_transform.origin
			
			Global.gizmo_highlighted = false
			var closes_axis_dist = INF
			if hit:
				hit.position.distance_squared_to(from)
			axis_highlighting = -1
			if not Global.selected.y_only:
				var planex = Plane($Z/Y/X.global_transform.basis.x,0)
				intersection_x = planex.intersects_ray(from,to)
				if intersection_x:
					intersection_x/=scl
					var xlen = intersection_x.length()
					var xdist = intersection_x.distance_squared_to(from)
					if xlen < ring_high and xlen > ring_low and closes_axis_dist > xdist:
						axis_highlighting = AXIS.x
						closes_axis_dist = xdist
						Global.gizmo_highlighted = true
			
			var planey = Plane($Z/Y.global_transform.basis.y,0)
			intersection_y = planey.intersects_ray(from,to)
			if intersection_y:
				intersection_y/=scl
				var ylen = intersection_y.length()
				var ydist = intersection_y.distance_squared_to(from)
				if (ylen < ring_high and ylen > ring_low) and closes_axis_dist > ydist:
					axis_highlighting = AXIS.y
					closes_axis_dist = ydist
					Global.gizmo_highlighted = true
			if not Global.selected.y_only:
				var planez = Plane($Z.global_transform.basis.z,0)
				intersection_z = planez.intersects_ray(from,to)
				if intersection_z:
					intersection_z/=scl
					var zlen = intersection_z.length()
					var zdist = intersection_z.distance_squared_to(from)
					if (zlen < ring_high and zlen > ring_low) and closes_axis_dist > zdist:
						axis_highlighting = AXIS.z
						closes_axis_dist = zdist
						Global.gizmo_highlighted = true
			
			
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed and not event.is_echo():
				if Global.gizmo_highlighted:
					dragging = true
				axis_selected = axis_highlighting
				match axis_selected:
					AXIS.x:
						last_intersection_pos = intersection_x
						local_last = $Z/Y/X.global_transform.basis.xform_inv(last_intersection_pos)
					AXIS.y:
						last_intersection_pos = intersection_y
						local_last = $Z/Y.global_transform.basis.xform_inv(last_intersection_pos)
					AXIS.z:
						last_intersection_pos = intersection_z
						local_last = $Z.global_transform.basis.xform_inv(last_intersection_pos)
			if event.button_index == BUTTON_LEFT and not event.pressed and not event.is_echo():
				dragging = false
		var valid_selected = true
		match axis_selected:
			AXIS.x:
				valid_selected = (intersection_x != null)
			AXIS.y:
				valid_selected = (intersection_y != null)
			AXIS.z:
				valid_selected = (intersection_z != null)
		if dragging and valid_selected:
			var change = false
			material_x.flags_transparent = axis_selected != AXIS.x
			material_y.flags_transparent = axis_selected != AXIS.y
			material_z.flags_transparent = axis_selected != AXIS.z
			match axis_selected:
				AXIS.x:
					var local_current = $Z/Y/X.global_transform.basis.xform_inv(intersection_x)
					var angle_diff = Vector2(local_current.y,local_current.z).angle()-Vector2(local_last.y,local_last.z).angle()
					true_rot_raw.x += angle_diff
					local_last = $Z/Y/X.global_transform.basis.xform_inv(last_intersection_pos)
					last_intersection_pos = intersection_x
				AXIS.y:
					var local_current = $Z/Y.global_transform.basis.xform_inv(intersection_y)
					var angle_diff = Vector2(local_current.x,local_current.z).angle()-Vector2(local_last.x,local_last.z).angle()
					true_rot_raw.y += angle_diff
					local_last = $Z/Y.global_transform.basis.xform_inv(last_intersection_pos)
					last_intersection_pos = intersection_y
				AXIS.z:
					var local_current = $Z.global_transform.basis.xform_inv(intersection_z)
					var angle_diff = Vector2(local_current.x,local_current.y).angle()-Vector2(local_last.x,local_last.y).angle()
					true_rot_raw.z -= angle_diff
					local_last = $Z.global_transform.basis.xform_inv(last_intersection_pos)
					last_intersection_pos = intersection_z
				
			true_rot = Vector3(Global.snap(true_rot_raw.x),Global.snap(true_rot_raw.y),Global.snap(true_rot_raw.z))
			$Z/Y/X.rotation.x = true_rot_raw.x
			$Z/Y.rotation.y = -true_rot_raw.y
			$Z.rotation.z = -true_rot_raw.z
			Global.selected.true_rotation = true_rot
			Global.emit_signal("selected_rotation_changed",self)
		else:
			material_x.flags_transparent = axis_highlighting != AXIS.x
			material_y.flags_transparent = axis_highlighting != AXIS.y
			material_z.flags_transparent = axis_highlighting != AXIS.z
