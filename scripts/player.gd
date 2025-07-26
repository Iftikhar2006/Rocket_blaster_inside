extends CharacterBody2D


var SPEED = 300.0
const left_offset : int = -300
const right_offset : int = 300
const BULLET = preload("res://scenes/bullet.tscn")
var is_shoooting : bool = false
var health : int = 50
var is_hurt : bool = false
@onready var health_label: Label = $"../HealthLabel"



func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if position.x<left_offset and direction == -1:
		velocity.x = 0
	elif position.x>right_offset and direction == 1:
		velocity.x = 0
	elif direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_pressed("Shoot") and not is_shoooting:
		shoot()
		$Cooldown.start()
		is_shoooting=true
	move_and_slide()
	health_label.text = "Health:"+ str(health)
	



func shoot():
	var bullet1 = BULLET.instantiate()
	var bullet2 = BULLET.instantiate()
	var bullet3 = BULLET.instantiate()
	var bullet4 = BULLET.instantiate()
	bullet1.position = position + Vector2(-33,-20)
	bullet2.position = position + Vector2(33,-20)
	bullet3.position = position + Vector2(19,-27)
	bullet4.position = position + Vector2(-19,-27)
	bullet1.get_node("killZone").source_is_player = true
	bullet2.get_node("killZone").source_is_player = true
	bullet3.get_node("killZone").source_is_player = true
	bullet4.get_node("killZone").source_is_player = true
	get_tree().current_scene.add_child(bullet1)
	get_tree().current_scene.add_child(bullet2)
	get_tree().current_scene.add_child(bullet3)
	get_tree().current_scene.add_child(bullet4)


func _on_cooldown_timeout() -> void:
	is_shoooting = false

func hit():
	if health:
		health -= 1
		if not is_hurt:
			$hurt.start()
			is_hurt = true
			SPEED = 100
		#print("player"+ str(health))
	else:
		game_over()


#Events on game over
func game_over():
	print("GAme over")
	get_tree().change_scene_to_file("res://scenes/end_1.tscn")



func _on_hurt_timeout() -> void:
	is_hurt = false
	SPEED = move_toward(100,300,150)
	
