extends Area2D

signal hit
@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get player direction
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	# Normalize player movement to prevent double input
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	# Move player
	position += velocity * delta
	# Prevent player from going off screen
	position = position.clamp(Vector2.ZERO, screen_size)
	# Start animation
	$AnimatedSprite2D.play()

# Called when start button is pressed
func start(pos):
	position = pos
	show()
	$AnimatedSprite2D.animation = "spaceship"
	# Enable collision
	$CollisionShape2D.disabled = false

# Called when body_entered signal is received
func _on_body_entered(body):
	hide()
	hit.emit()
	# Disable collision
	$CollisionShape2D.set_deferred("disabled", true)
