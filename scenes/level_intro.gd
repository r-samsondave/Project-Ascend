extends Control


func _ready():
	$HideTimer.start()
	$AnimationPlayer.play("fade_in")
	
func _on_hide_timer_timeout():
	$AnimationPlayer.play("fade_out")
