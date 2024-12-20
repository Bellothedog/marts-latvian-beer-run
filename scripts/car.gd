extends VehicleBody3D

const MAX_STEER = 0.3 # Rad
const ENGINE_POWER = 300 # Per traction wheel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	steering = move_toward(steering, Input.get_axis("ui_left", "ui_right") * MAX_STEER, delta * 2.5) # R: 1, L: -1
	engine_force = Input.get_axis("ui_down", "ui_up") * ENGINE_POWER
