extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	print(area)
	if str(area.name) =="BigEnemy":
		area.queue_free()
		print(-1)
		pass
	if str(area.name) =="BigEnemy2":
		area.queue_free()
		print(-1)
		pass
	if str(area.name) =="Friend":
		area.queue_free()
		print(+1)
		pass
