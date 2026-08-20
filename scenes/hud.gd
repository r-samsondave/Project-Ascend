extends CanvasLayer

var lives = 7

@onready var hearts = [
	$Lives/Heart1,
	$Lives/Heart2,
	$Lives/Heart3,
	$Lives/Heart4,
	$Lives/Heart5,
	$Lives/Heart6,
	$Lives/Heart7	
]

func lose_life():
	lives -= 1

	hearts[lives].visible = false
