tool
extends VBoxContainer

export(String) var Name setget _set_name

var remove = true
var replace = true
var place = true

signal values_changed
var ready = false
func _set_name(n):
	Name = n
	if ready:
		$HBoxContainer/Label.text = n

var layout = [false,false,false]
var valid_layouts = [
	[false,false,true],
	[true,false,false],
	[false,true,true],
	[true,true,true],
	[false,false,false],
]

func _ready():
	ready = true
	_set_name(Name)

func _on_CheckBoxRemove_toggled(toggle):
	remove = toggle
	emit_signal("values_changed",remove,replace,place)

func _on_CheckBoxReplace_toggled(toggle):
	replace = toggle
	emit_signal("values_changed",remove,replace,place)

func _on_CheckBoxPlace_toggled(toggle):
	place = toggle
	emit_signal("values_changed",remove,replace,place)

