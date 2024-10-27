class_name Arabian_Wolf
extends CharacterBody2D

signal rescue

#var data
@export var howl: AudioStream
@export var get_wolf : AudioStream
var arabian_wolf_almanac = preload("res://Assets/Scences/UI/Wolf_Almanac/Book/Arabian Wolf/arabian_wolf_almanac.tscn").instantiate()

#var node
@onready var rescue_area = $Area2D
@onready var howling = $Howling
@onready var sprites = $AnimatedSprite2D

func _on_area_2d_body_entered(body):
	if body as Players:
		_on_rescue()
		sprites.play("Howling")
		howl.play()
		if howling.finished:
			get_tree().root.remove_child(self)
			get_wolf.play()
		WolfData._set_Arabian_Wolf_Rescue_Status(true)
		#Image
		almanac.setter_Wolf_Image(WolfData._get_Araian_Wolf_Image_Path())
		#Name
		almanac.setter_Wolf_Name(WolfData._get_Arabian_Wolf_Name())
		#Species
		almanac.setter_Wolf_Species(WolfData._get_Alexander_ArchipelagoWolf_Species())
		#Height
		almanac.setter_Wolf_Height(WolfData._get_Arabian_Wolf_Height())
		#Weight
		almanac.setter_Wolf_Weight(WolfData._get_Arabian_Wolf_Weight())
		#Lenght
		almanac.setter_Wolf_Lenght(WolfData._get_Arabian_Wolf_Lenght())
		#Conservation Status
		almanac.setter_Wolf_Conservation_Status(WolfData._get_Arabian_Wolf_Conservation_Status())
		#Region
		almanac.setter_Wolf_Region(WolfData._get_Arabian_Wolf_Location())
		#Morphology
		almanac.setter_Wolf_Morphology(WolfData._get_Arabian_Wolf_Morphology())
		#Diets
		almanac.setter_Wolf_Diets(WolfData._get_Arabian_Wolf_Diets())
		get_tree().change_scene_to_packed(arabian_wolf_almanac)
		get_tree().root.add_child(arabian_wolf_almanac)
	
func _on_rescue():
	mission_data_stat.update_wolf_rescue()
