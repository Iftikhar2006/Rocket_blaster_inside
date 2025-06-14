extends Node2D
const player_start_position := Vector2i(0,250)
const camera_start_position := Vector2i(0,0)
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
var entity_type = "Boundary"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.position = player_start_position
	$Camera2D.position = camera_start_position 
	$Spawn_rate.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass





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
