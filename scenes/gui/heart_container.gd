extends HBoxContainer

@onready var HeartGuiClass = preload("res://scenes/gui/heart.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setMaxHearts(max: int):
	for i in range(max):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)
		
func updateHearts(currentHealth: int):
	var hearts = get_children();

	# from 0 through current health, set the bars to be full, otherwise empty
	for i in range(hearts.size()):
		var whole = true if (i < currentHealth) else false
		hearts[i].update(whole)
		
