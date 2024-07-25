extends Node

@export var mob_scene: PackedScene
var hiscore = 0
var score = 0
var max_mob_speed = 250.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$Music.pitch_scale += 0.0000015
	$Music.pitch_scale += 0.000015

# Called when player hits a rock
# Updates highscore, stops timers + music and plays death sound
func game_over():
	if hiscore < score:
		hiscore = score
	$HUD.update_score(hiscore, score)
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

# Called when start button is pressed
func new_game():
	# Delete mobs on screen
	get_tree().call_group("mobs", "queue_free")
	# Set starting values
	$Player.speed = 400.0
	$MobTimer.wait_time = 1.0
	max_mob_speed = 250.0
	$Music.pitch_scale = 0.85
	score = 0
	# Start game
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(hiscore, score)
	$HUD.show_message("get ready")
	$Music.play()

# Called inside _on_score_timer_timeout()
# Makes player and mob speed faster, and spawns mob faster
func increase_difficulty():
	# Push announcement for scaling difficulty
	if (score == 30):
		$HUD.announcement("getting faster...")
	$Player.speed += 3.25
	max_mob_speed += 3.25
	$MobTimer.wait_time *= 0.985

# Called on MobTimer timeout
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	# Randomize mob spawn location
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	# Randomize travel direction
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set variety in mob speed
	var velocity = Vector2(randf_range(max_mob_speed - 75.0, max_mob_speed), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	# Spawn in mob
	add_child(mob)

# Called on ScoreTimer timeout
# Increases difficulty and updates score
func _on_score_timer_timeout():
	increase_difficulty()
	score += 1
	$HUD.update_score(hiscore, score)

# Called on StartTimer timeout
func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
