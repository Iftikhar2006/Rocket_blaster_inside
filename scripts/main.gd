extends Node2D
const player_start_position := Vector2i(0,250)
const camera_start_position := Vector2i(0,0)
@onready var score_label: Label = $ScoreLabel
@onready var health_label: Label = $HealthLabel
const Max_score:int = 100
const speed : int = 200
const left_offset : int = -300
const right_offset : int = 300
var difficulty = 3
const BIG_ENEMY = preload("res://scenes/big_enemy.tscn")
const BIG_ENEMY_2 = preload("res://scenes/big_enemy_2.tscn")
const FRIEND = preload("res://scenes/friend.tscn")
const Red = preload("res://scenes/area_2d.tscn")
const Yellow = preload("res://scenes/yellow_pointer.tscn")
const Green = preload("res://scenes/green_pointer.tscn")
var poniters := [Red,Yellow,Green]
var plane_types := [BIG_ENEMY,BIG_ENEMY_2,FRIEND]
@onready var countdown: Timer = $Countdown
@onready var countdown_label: Label = $CountdownLabel
var entity_type = "Boundary"
var score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.position = player_start_position
	$Camera2D.position = camera_start_position 
	$Spawn_rate.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if score==Max_score:
		print("TAsk COmpleted")
		get_tree().change_scene_to_file("res://scenes/end_2.tscn")
	show_time_left()





func _on_spawn_rate_timeout() -> void:
	for i in range(randi()%difficulty + 1):
		var random = randi() % 3
		var pointer_type = poniters[random]
		var pointer = pointer_type.instantiate()
		var plane_type = plane_types[random]
		var plane = plane_type.instantiate()
		plane.position.x = (randi()%550)-275
		pointer.position.x = plane.position.x
		plane.position.y = (randi()%550)-1000
		pointer.position.y = -310
		add_child(pointer)
		add_child(plane)
	$Spawn_rate.start()

func IncreaseScore( int ):
	score = score + int
	score_label.text = "Score:" + str(score)
	print("score-" + str(score))


func _on_countdown_timeout() -> void:
	call_deferred("game_over")


func show_time_left():
	var time_left = countdown.time_left
	var rounded_time =int(round(time_left)) 
	#print(rounded_time)  
	var minute = int(rounded_time/60)
	var sec = rounded_time - minute*60
	countdown_label.text = "Time left: " + str(minute) + ":" + str(sec)
	if rounded_time <31:
		pulse()
	
 # function to flicker the timer as red to show warning for low time
func pulse():
	var time_left = countdown.time_left
	var rounded_time =int(round(time_left*10)) 
	if rounded_time%2 == 0:
		countdown_label.add_theme_color_override("font_color",Color.RED)
	else:
		countdown_label.add_theme_color_override("font_color",Color.WHITE)
	pass

func game_over():
	print("GAme over")
	get_tree().change_scene_to_file("res://scenes/end_1.tscn")
