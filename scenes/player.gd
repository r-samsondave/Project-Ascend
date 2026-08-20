extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 1200.0
const COYOTE_TIME = 0.15

var coyote_timer = 0.0
var spawn_position
var is_dead = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var hud = $"../HUD"


func _ready():
	spawn_position = global_position

func set_checkpoint(new_position):
	spawn_position = new_position

func die():
	if is_dead:
		return

	is_dead = true
	hud.lose_life()
	velocity = Vector2.ZERO

	$DeathSE.play()
	animated_sprite.play("death")

	await animated_sprite.animation_finished

	global_position = spawn_position

	$RespawnSE.play()
	is_dead = false


func _physics_process(delta):
	# Coyote time
	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta

	if is_dead:
		return

	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Jump
	if Input.is_action_just_pressed("space_jump") and coyote_timer > 0:
		$JumpSE.play()
		velocity.y = JUMP_VELOCITY
		coyote_timer = 0

	# Movement
	var direction = Input.get_axis("walk_left", "walk_right")
	velocity.x = direction * SPEED

	# Animation
	if not is_on_floor():
		animated_sprite.play("jump")

		if direction != 0:
			animated_sprite.flip_h = direction < 0

	elif direction != 0:
		animated_sprite.play("walk")
		animated_sprite.flip_h = direction < 0

	else:
		animated_sprite.play("idle")

	move_and_slide()

	# Fell out of the level
	if global_position.y > 600:
		die()
