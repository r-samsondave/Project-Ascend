extends Control

@export var sign_texture: Texture2D

func _ready():
	$Sign.texture = sign_texture
	$HideTimer.start()
	$AnimationPlayer.play("fade_in")

func _on_hide_timer_timeout():
	$AnimationPlayer.play("fade_out")
