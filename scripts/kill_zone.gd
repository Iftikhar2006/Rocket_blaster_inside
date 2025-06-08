extends Area2D

var source_is_player : bool = false
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.hit()
		get_parent().direction=0
		get_parent().get_node("AnimationPlayer").play("boom")


func _on_area_entered(area: Area2D) -> void:
	if not source_is_player:
		return
	if area.name=="killZone":
		return
	if area.name == "RedPointer":
		return
	area.hit()
	get_parent().direction=0
	get_parent().get_node("AnimationPlayer").play("boom")
