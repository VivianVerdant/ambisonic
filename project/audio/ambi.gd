tool
extends Node

export var playing: bool = false setget toggle_playing
export var volume: float = 0.0 setget set_volume

onready var ambi = {
	"left"	: get_node("%left"),
	"right"	: get_node("%right"),
	"front"	: get_node("%front"),
	"back"	: get_node("%back"),
	"up"	: get_node("%up"),
	"down"	: get_node("%down"),
}

func _ready():
	pass

func toggle_playing(value):
	playing = value
	for channel in ambi.values():
		channel.playing = value

func set_volume(value):
	volume = value
	for channel in ambi.values():
		channel.volume_db = value


func _on_CheckButton_toggled(button_pressed):
	self.playing = button_pressed
