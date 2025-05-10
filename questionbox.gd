extends CenterContainer

@export var button_one_is_right: bool

@onready var label: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer

func _on_button_pressed() -> void:
	if button_one_is_right:
		label.text = "OK"
		hbox.hide()
	else:
		label.text = "NOT OK"
		hbox.hide()
		


func _on_button_2_pressed() -> void:
	if not button_one_is_right:
		label.text = "OK"
		hbox.hide()
	else:
		label.text = "NOT OK"
		hbox.hide()
		
func _input(event: InputEvent) -> void:
	if not hbox.visible and Input.is_action_just_pressed("ui_click"):
		queue_free()
