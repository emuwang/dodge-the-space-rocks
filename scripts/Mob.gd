extends RigidBody2D
var rotation_speed 

# Called when the node enters the scene tree for the first time.
# Randomize rock, initial rotation, and rotation speed
func _ready():
	var loadnum = randi_range(1, 5)
	$Sprite2D.texture = load("res://art/rock-" + str(loadnum) + ".png")
	$Sprite2D.rotation = randi_range(0, 360)
	rotation_speed = randf_range(0.02, 0.07)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Rotate rock
func _process(delta):
	$Sprite2D.rotation += rotation_speed;

# Called when mob exits screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
