extends CanvasLayer




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Label.text = str(Global.contador)
	$Label.text = str(Global.vida)
