extends Node2D

@export var game_spaces: Array[Spot]
@export var question_boxs: Array[PackedScene]

@onready var pink_piece: Sprite2D = $PinkPiece
@onready var dice := $Dice
@onready var timer: Timer = $Timer
@onready var canvas_layer: CanvasLayer = $CanvasLayer

var place: int = 0
var number_of_spaces: int 

func _ready() -> void:
	number_of_spaces = game_spaces.size()

func _on_dice_dice_has_rolled(roll: Variant) -> void:
	roll = 6
	
	while roll != 0:
		await(move(place))
		place += 1
		roll -= 1

	if roll == 0:
		await(move(place)) 
		if game_spaces[place].direction == Direction.WhichWay.BACK:
			print("BACK")
			var two_space_back = place - 2
			while place != two_space_back:
				place -= 1
				await(move(place)) 
		if place == 12:
			print("FORW")
			var two_space_forward = place + 2
			while place != two_space_forward:
				await(move(place))
				place += 1
		
		print("DIR:", game_spaces[place].direction)
		print("WW:", Direction.WhichWay.QUESTION)
		print("GG:", game_spaces[place])
		if game_spaces[place].direction == Direction.WhichWay.QUESTION:
			question_boxs.shuffle()
			var question_box = question_boxs.front()
			var question = question_box.instantiate()
			canvas_layer.add_child(question)

func move(place) -> void:
	if place == 0:
		return
	print("move to:", game_spaces[place].position)
	var tween = create_tween()
	tween.tween_property(pink_piece, "position", game_spaces[place].position, 1)
	timer.start()
	await timer.timeout 
