extends Node2D

class_name Character
@export var is_player : bool
@export var cur_hp : int 
@export var max_hp : int
@export var target: Node
@export var visual: Texture2D
@export var flip_visual: bool
@export var combat_actions : Array
@export var opponent : Node
var whos_up : Node
@onready var health_bar : ProgressBar = get_node("DebugBar")
@onready var health_text : Label = get_node("DebugBar/DebugText")
var fullGame = false



# Called when the node enters the scene tree for the first time.
func _ready(): 
	$Sprite.flip_h = flip_visual
	get_node("/root/BattleScene").character_begin_turn.connect(_on_character_begin_turn)
	health_bar.max_value = max_hp
	health_text.text = str(cur_hp, " / ", max_hp)

func _on_character_begin_turn(character):
	if character == self and is_player == false:
		_decide_combat_action()

func cast_combat_action(action):
	if action.damage > 0:
		opponent.get_hurt(action.damage)
	elif action.heal > 0:
		heal(action.heal)
	
	get_parent().end_current_turn()

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
		get_node("/root/BattleScene").char_death(self)
		queue_free()

func _decide_combat_action ():
	var health_percent = float(cur_hp) / float(max_hp)
	
	for i in combat_actions:
		var action = i as CombatAction
		
		if action.heal > 0:
			if randf() > health_percent + 0.2:
				cast_combat_action(action)
				return
			else:
				continue
		else:
			cast_combat_action(action)
			return



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
