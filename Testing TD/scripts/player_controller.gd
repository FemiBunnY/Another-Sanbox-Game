class_name Player
extends CharacterBody2D

@onready var player_sprite = $PlayerSprite
@onready var looking_at_ray = $LookingAt
@onready var tile_map = $".."

var direction:Vector2
var speed:int = 100

func _ready():
	pass

func _physics_process(delta):
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	
	looking_at()
	
	if Input.is_action_just_pressed("interact") and looking_at_ray.get_collider():
		tile_map.erase_cell(1, Vector2i(tile_map.local_to_map(looking_at_ray.get_collision_point()).x+50, tile_map.local_to_map(looking_at_ray.get_collision_point()).y+49))
	
	velocity.x = lerp(velocity.x, direction.x * speed, 0.5)
	velocity.y = lerp(velocity.y, direction.y * speed, 0.5)
	move_and_slide()


	
func looking_at():
	if direction.x < 0:
		looking_at_ray.set_rotation(deg_to_rad(90))
	elif direction.x > 0:
		looking_at_ray.set_rotation(deg_to_rad(-90))
	if direction.y < 0:
		looking_at_ray.set_rotation(deg_to_rad(180))
	elif direction.y > 0:
		looking_at_ray.set_rotation(deg_to_rad(0))
