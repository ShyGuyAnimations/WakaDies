extends Node2D

@export var player_char : Character
@export var enemy_char : Character
@export var next_turn_time : float
var cur_char : Character 
var game_over : bool = false
var turn_count : int = 0

signal character_begin_turn
signal character_end_turn 

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	begin_next_turn()

func begin_next_turn(): 
	if cur_char == player_char:
		cur_char = enemy_char
	elif cur_char == enemy_char:
		cur_char = player_char
	else:
		cur_char = player_char
	character_begin_turn.emit(cur_char)
	
	if cur_char == player_char:
		turn_count = turn_count + 1
	print(turn_count, " ", cur_char)



func end_current_turn():
	await get_tree().create_timer(next_turn_time).timeout 
	character_end_turn.emit(cur_char)
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
	pass
