extends Node2D

@onready var tile_map = $TileMap
@export var noise_texture:NoiseTexture2D

var width:int = 100
var height:int = 100

var full_map:Array
var pos_grass:Array
var pos_trees:Array

func _ready():
	generate_map()
	
func generate_map():
	tile_map.clear()
	
	noise_texture.noise.seed = randi()
	
	while noise_texture.noise.get_noise_2d(50, 50) < 0:
		noise_texture.noise.seed = randi()
	
	for x in range(width):
		for y in range(height):
			var pixel_noise:float = noise_texture.noise.get_noise_2d(x, y)
			if pixel_noise < 0:
				pass
			elif pixel_noise > 0:
				full_map.append(Vector2i(x, y))
				if pixel_noise > 0.43:
					pos_grass.append(Vector2i(x, y))
				if pixel_noise > 0.1 and pixel_noise < 0.2:
					pos_trees.append(Vector2i(x, y))
					
	tile_map.set_cells_terrain_connect(0, full_map, 0, 0)
	
	for i in pos_grass:
		var t:int = randi_range(0, 3)
		if t == 0:
			tile_map.set_cell(0, i, 0, Vector2i(5, 5))
		elif t == 1:
			tile_map.set_cell(0, i, 0, Vector2i(5, 6))
		elif t == 2:
			tile_map.set_cell(0, i, 0, Vector2i(1, 5))
		elif t == 3:
			tile_map.set_cell(0, i, 0, Vector2i(2, 5))
			
	for i in pos_trees:
		var t:int = randi_range(0, 2)
		if t == 0:
			pass
		if t == 1:
			tile_map.set_cell(1, i, 1, Vector2i(0, 0))
		if t == 2:
			tile_map.set_cell(1, i, 1, Vector2i(1, 0))
