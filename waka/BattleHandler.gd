extends Node2D

@onready var sprite = $Icon
@export var player_char : Character
@export var enemy_char : Character
@export var next_turn_time : float
var cur_char : Character 
var game_over : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	pass # Replace with function body.

func begin_next_turn(): 
	if cur_char == player_char:
		cur_char = enemy_char
	elif cur_char == enemy_char:
		cur_char = player_char
	else:
		cur_char = player_char

func end_current_turn():
	await get_tree().create_timer(next_turn_time).timeout 
	if game_over == false:
		begin_next_turn()

func char_death(character):
	"review this for full game"
	game_over = true
	if character.is_player == true:
		print("game over")
	else:
		print("yippee")
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite.rotate(delta*3)
	if sprite.rotation_degrees > 360:
		sprite.rotation_degrees = sprite.rotation_degrees - 360
	#print(sprite.rotation_degrees)
 
