extends RigidBody3D

@onready var car_mesh = $lada_blue
@onready var body_mesh = $lada_blue
@onready var ground_ray = $lada_blue/RayCast3D

# For offsetting car mesh position relative to the sphere
var sphere_offset = Vector3.DOWN
# Engine power
var acceleration = 35.0
# Turm amount (deg)
var steering = 18.0
# Turn speed
var turn_speed = 4.0
# No turning below this speed
var turn_stop_limit = 0.75

# Input value variables
var speed_input = 0
var turn_input = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Position car mesh at rigidbody's current position
	car_mesh.position = position + sphere_offset
	if ground_ray.is_colliding():
		apply_central_force(-car_mesh.global_transform.basis.z * speed_input)
		
func _process(delta):
	if not ground_ray.is_colliding():
		return
	speed_input = Input.get_axis("accelerate", "brake") * acceleration
	turn_input = Input.get_axis("steer_right", "steer_left") * deg_to_rad(steering)
	# Rotate car mesh
	if linear_velocity.length() > turn_stop_limit:
		var new_basis = car_mesh.global_transform.basis.rotated(car_mesh.global_transform.basis.y, turn_input)
		car_mesh.global_transform.basis = car_mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
		car_mesh.global_transform = car_mesh.global_transform.orthonormalized()
		# TODO: look into orthonormalized() and transform (basises) in general!
	
