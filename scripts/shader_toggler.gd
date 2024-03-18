extends ColorRect

func _process(delta):
	if Input.is_action_just_pressed("enable_disable_shader"):
		visible = !visible
