extends Node2D

const speed = 400
var direction :int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LifeTime.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= speed*delta*direction
	pass


func _on_life_time_timeout() -> void:
	queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
