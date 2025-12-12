extends Node2D

class_name Character
@export var is_player : bool
@export var cur_hp : int 
@export var max_hp : int
@export var target: Node
var whos_up : Node
@onready var health_bar : ProgressBar = get_node("DebugBar")
@onready var health_text : Label = get_node("DebugBar/DebugText")
var fullGame = false

# Called when the node enters the scene tree for the first time.
func _ready(): 
	health_bar.max_value = max_hp
	health_text.text = str(cur_hp, " / ", max_hp)


func _update_health_bar():
	health_bar.value = cur_hp
	health_text.text = str(cur_hp, " / ", max_hp)

func heal (amount):
	cur_hp += amount
	if cur_hp > max_hp:
		cur_hp = max_hp
	_update_health_bar()

func get_hurt(damage):
	cur_hp -= damage
	_update_health_bar()
	if cur_hp <= 0:
		"if fullGame:"
		"_game_over()"
		"else:"
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
