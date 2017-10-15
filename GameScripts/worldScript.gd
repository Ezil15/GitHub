extends Node
var worldSize = 65
onready var TileM = get_node("FloorTiles")
var TreeTile = preload("res://Scenes/TreeTile.tscn")
var WaterTile = preload("res://Scenes/WaterTile.tscn")
var StoneTile = preload("res://Scenes/StoneTile.tscn")
var preScript = preload("res://GameScripts/softnoise.gd")
var softnoise

func _ready():
	set_fixed_process(true)
	generate("grass")
	
func _fixed_process(delta):
	if Input.is_action_pressed("ui_up"):
		reGen()
		

func generate(GenType):
	if GenType == "grass":
		for y in range(-worldSize,worldSize):
			for x in range(-worldSize,worldSize):
				TileM.set_cell(x,y,0)
	
	if GenType == "other":
		softnoise = preScript.SoftNoise.new()
		for x in range(-worldSize,worldSize):
			for y in range(-worldSize,worldSize):
				var intY = softnoise.cosineInterpolation(y,y,0)
				var intX = softnoise.cosineInterpolation(x,x,0)
				if (softnoise.openSimplex2D(intX/18, intY/18)) > 0.3 and (softnoise.openSimplex2D(intX/18, intY/18)) < 0.5:
					var T = TreeTile.instance()
					var Vec = Vector2(x,y)
					var VecMap = TileM.map_to_world(Vec)
					VecMap.x += 0
					VecMap.y += 16
					T.set_pos(VecMap)
					var RandFl = randf()*0.15+0.9
					T.get_node("Sprite").set_modulate(Color(1,RandFl,1,1))
					get_node("Nature").add_child(T)
				elif (softnoise.openSimplex2D(intX/18, intY/18)) > -0.4 and (softnoise.openSimplex2D(intX/18, intY/18)) < -0.3:
					var W = WaterTile.instance()
					var Vec = Vector2(x,y)
					var VecMap = TileM.map_to_world(Vec)
					VecMap.x += 0
					VecMap.y += 16
					W.set_pos(VecMap)
					W.get_node("Sprite").set_modulate(Color(90,90,0.5,1))
					get_node("Water").add_child(W)

				elif (softnoise.openSimplex2D(intX/18, intY/18)) < -0.4:
					var W = WaterTile.instance()
					var Vec = Vector2(x,y)
					var VecMap = TileM.map_to_world(Vec)
					VecMap.x += 0
					VecMap.y += 16
					W.set_pos(VecMap)
					get_node("Water").add_child(W)
				
				elif (softnoise.openSimplex2D(intX/18, intY/18)) > 0.5:
					var S = StoneTile.instance()
					var Vec = Vector2(x,y)
					var VecMap = TileM.map_to_world(Vec)
					VecMap.x += 0
					VecMap.y += 8
					S.set_pos(VecMap)
					get_node("Nature").add_child(S)
func reGen():
	var ArrayNature = get_node("Nature").get_children()
	var ArrayWater = get_node("Water").get_children()
	for i in range(ArrayWater.size()):
		ArrayWater[i].free()
	for i in range(ArrayNature.size()):
		ArrayNature[i].free()
	generate("other")