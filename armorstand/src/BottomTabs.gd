extends TabContainer


const transition_duration = 0.5

func _on_BottomTabs_tab_changed(tab):
	if tab == 0:
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
		tween.tween_property(self,"margin_top",-44.0,transition_duration)
		tween.tween_property(self,"margin_bottom",52.0,transition_duration)
		tween.tween_property(self,"anchor_top",1.0,transition_duration)
	elif tab == 1:
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
		tween.tween_property(self,"margin_top",16.0,transition_duration)
		tween.tween_property(self,"margin_bottom",0.0,transition_duration)
		tween.tween_property(self,"anchor_top",0.0,transition_duration)
	elif tab == 2:
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
		tween.tween_property(self,"margin_top",-216.0,transition_duration)
		tween.tween_property(self,"margin_bottom",0.0,transition_duration)
		tween.tween_property(self,"anchor_top",1.0,transition_duration)

func _on_ClipboardButton_pressed():
	OS.clipboard = $Export/VBoxContainer/HBoxContainer/Command.text
