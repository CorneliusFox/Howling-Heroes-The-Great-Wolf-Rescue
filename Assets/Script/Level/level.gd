class_name Level
extends Node2D

signal exit_reached(next_level:String)
@export var taiga_music:AudioStream
@export var tundra_music:AudioStream
@export var grassland_music : AudioStream
@export var dessert_music :AudioStream

@onready var music = $backsound
var save = SaveLoadManagerFile.new()
var data = load("user://Save/Progress/Save_Progress.tres")
# We don't export a packed scene here to avoid circular references between scenes.
@export_file("*.tscn") var next_level:String




func _ready():
	if exit_reached.get_connections().size() == 0:
		push_warning(get_path(), " exit_reached is not connected, this doesn't look right.")
	
	var level_exits = get_tree().get_nodes_in_group("level_exit")
	for exit in level_exits:
		exit.exit_reached.connect(_on_exit_reached)
	if data is Data_Progress:
		player_singleton.setter_location(data.player_biome_location)
		if player_singleton.getter_location() == "Taiga":
			Music.start_track(taiga_music)
		elif player_singleton.getter_location() == "Tundra":
			Music.start_track(tundra_music)
		elif player_singleton.getter_location() == "Grassland":
			Music.start_track(grassland_music)
		else :
			Music.start_track(dessert_music)
	else : 
		print("Failed to load resource data.")
func _on_exit_reached():
	exit_reached.emit(next_level)


