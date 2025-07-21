extends Area2D

var speed : int = 100
var health : int = 20
var hostile : bool = false
var is_dying : bool = false
const BULLET = preload("res://scenes/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed*delta
	if health == 0:
		is_dying = true
		#print("I died")
		queue_free() 


func hit():
	speed = 50
	speed = move_toward(50,100,10)
	if health:
		health -= 1
	#print("Friend" + str(health) )
	if not hostile:
		hostile = true
		$Timer.start()
	if health==0:
		var main = get_tree().get_current_scene()
		main.IncreaseScore(-20)


#infinite loop using timer for shooting

func _on_timer_timeout() -> void:
	if is_dying:
		return
	var bullet1 = BULLET.instantiate()
	var bullet2 = BULLET.instantiate()
	bullet1.direction = -1
	bullet2.direction = -1
	bullet1.position = position + Vector2(30,20)
	bullet2.position = position + Vector2(-30,20)
	get_tree().current_scene.add_child(bullet1)
	get_tree().current_scene.add_child(bullet2)
	$Timer.start()
