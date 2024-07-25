extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Shows a quick announcement
func announcement(text):
	$Message.text = text
	$Message.show()
	# Create oneshot timer
	await get_tree().create_timer(1.0).timeout
	$Message.hide()

# Called as helper function
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

# Called to show game over message and reset title screen
func show_game_over():
	$Message.text = "game over"
	await $MessageTimer.timeout
	$Message.text = "dodge the space rocks"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

# Called to update ScoreLabel
func update_score(hiscore, score):
	$ScoreLabel.text = ("high: " + str(hiscore) + "          curr: " + str(score))

# Called when StartButton is pressed
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

# Called on MessageTimer timeout
# Hides Message
func _on_message_timer_timeout():
	$Message.hide()
