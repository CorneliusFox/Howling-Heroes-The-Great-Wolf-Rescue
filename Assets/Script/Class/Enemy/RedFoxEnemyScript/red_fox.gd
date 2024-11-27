extends CharacterBody2D


@export var player: CharacterBody2D
@export var SPEED: int = 50;
@export var CHASE_SPEED: int = 150
@export var ACCELERATION: int = 300

@onready var sprite: Sprite2D =  $AnimatedSprite
@onready var ray_cast: RayCast2D = $AnimatedSprite/RayCast2D
@onready var timer = $Timer

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2
var right_bounds: Vector2
var left_bounds: Vector2 

enum States{
	WANDER,
	CHASE
}
var current_state = States.WANDER

func _ready():
	left_bounds = self.position + Vector2(-125, 0)
	right_bounds = self.position + Vector2(125, 0)
	

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_movement(delta)
	change_direction()
	look_for_player()

func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		

func _on_timer_timeout():
	current_state = States.WANDER


func handle_movement(delta: float) -> void:
	if current_state == States.WANDER:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else: 
		velocity = velocity.move_toward(direction * CHASE_SPEED, ACCELERATION*delta)

	move_and_slide()

func change_direction() -> void:
	if current_state == States.WANDER:
		if sprite.flip_h:
		#movingright
			if self.position.x <= right_bounds.x:
				direction = Vector2(1,0)
			else:
				#flip to moving left
				sprite.flip_h = false
				ray_cast.target_position = Vector2(-125,0)
		else:
			if self.position.x >= left_bounds.x:
				direction = Vector2(-1,0)
			else:
				#flip to moving left
				sprite.flip_h = true
				ray_cast.target_position = Vector2(125,0)
	else:
		#chase state
		direction = (player.position - self.position).normalized()
		direction = sign(direction)
		if direction.x == 1:
			#flip to moving right
			sprite.flip_h = true 
			ray_cast.target_position = Vector2(125,0)
		else:
			#fplip to moving left
			sprite.flip_h = false
			ray_cast.target_position = Vector2(-125,0)


func look_for_player():
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider == player:
			chase_player()
		elif current_state == States.CHASE:
			stop_chase()
	elif current_state == States.CHASE:
		stop_chase()


func chase_player() -> void:
	timer.stop()
	current_state = States.CHASE


func stop_chase() -> void:
	if timer.time_left <= 0:
		timer.start


