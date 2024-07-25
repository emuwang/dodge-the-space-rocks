extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.rotation = randi_range(0, 360)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.rotation += 0.05;

# Called when mob exits screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
