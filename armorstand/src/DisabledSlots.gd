extends VBoxContainer

var toggles = [
	false,false,false,false,false,false,
	false,false,false,false,false,false,
	false,false,false,false,false,false,
	]

func bitwise():
	var result = 0
	var x = 0
	for bit in toggles:
		if bit:
			result += pow(2,x)
		x += 1
		if x == 14:
			x = 16
		elif x == 6:
			x = 8
	ArmorStand.disabled_slots = result

func _on_DisableSlotHead_values_changed(remove,replace,place):
	toggles[4] = !remove
	toggles[10] = !replace
	toggles[16] = !place
	bitwise()


func _on_DisableSlotChestplate_values_changed(remove,replace,place):
	toggles[3] = !remove
	toggles[9] = !replace
	toggles[15] = !place
	bitwise()


func _on_DisableSlotLeggings_values_changed(remove,replace,place):
	toggles[2] = !remove
	toggles[8] = !replace
	toggles[14] = !place
	bitwise()


func _on_DisableSlotBoots_values_changed(remove,replace,place):
	toggles[1] = !remove
	toggles[7] = !replace
	toggles[13] = !place
	bitwise()


func _on_DisableSlotMainHand_values_changed(remove,replace,place):
	toggles[0] = !remove
	toggles[6] = !replace
	toggles[12] = !place
	bitwise()


func _on_DisableSlotOffHand_values_changed(remove,replace,place):
	toggles[5] = !remove
	toggles[11] = !replace
	toggles[17] = !place
	bitwise()
