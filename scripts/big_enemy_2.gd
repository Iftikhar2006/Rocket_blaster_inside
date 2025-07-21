extends Area2D

var speed : int = 100
var health : int = 20
const BULLET = preload("res://scenes/bullet.tscn")
var is_dying : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CoolDown.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed*delta
	if health == 0:
		if not is_dying:
			is_dying = true
			speed = 0
			$CollisionPolygon2D.disabled = true
			$LastBreath.start()


func hit():
	speed = 50
	speed = move_toward(50,100,10)
	if health:
		health -= 1
	#print("Enemy" + str(health) )
	if health==0:
		var main = get_tree().get_current_scene()
		main.IncreaseScore(10)


#infinite loop using timer for shooting
func _on_cool_down_timeout() -> void:
	if is_dying:
		return
	var bullet1 = BULLET.instantiate()
	var bullet2 = BULLET.instantiate()
	var bullet3 = BULLET.instantiate()
	var bullet4 = BULLET.instantiate()
	bullet1.direction = -1
	bullet2.direction = -1
	bullet3.direction = -1
	bullet4.direction = -1
	bullet1.position = position + Vector2(24,23)
	bullet2.position = position + Vector2(-24,23)
	bullet3.position = position + Vector2(33,23)
	bullet4.position = position + Vector2(-33,23)
	get_tree().current_scene.add_child(bullet1)
	get_tree().current_scene.add_child(bullet2)	
	get_tree().current_scene.add_child(bullet3)
	get_tree().current_scene.add_child(bullet4)


func _on_last_breath_timeout() -> void:
	#print("I died")
	queue_free()
