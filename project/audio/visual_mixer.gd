extends Control

export var volume: float = 0.0
export var auto: bool = false

# -----------------------------------------------------------------------
onready var left_right_balance = get_node("%LeftRightBalance")
onready var front_back_balance = get_node("%FrontBackBalance")
onready var up_down_balance    = get_node("%UpDownBalance")

onready var left_right_value = get_node("%ValueLeftRight")
onready var front_back_value = get_node("%ValueFrontBack")
onready var up_down_value    = get_node("%ValueUpDown")

# -----------------------------------------------------------------------
onready var visualizer_left  = get_node("%VisualizerLeft")
onready var visualizer_right = get_node("%VisualizerRight")

onready var visualizer_front = get_node("%VisualizerFront")
onready var visualizer_back  = get_node("%VisualizerBack")

onready var visualizer_up    = get_node("%VisualizerUp")
onready var visualizer_down  = get_node("%VisualizerDown")

# -----------------------------------------------------------------------
onready var value_left  = get_node("%ValueLeft")
onready var value_right = get_node("%ValueRight")

onready var value_front = get_node("%ValueFront")
onready var value_back  = get_node("%ValueBack")

onready var value_up    = get_node("%ValueUp")
onready var value_down  = get_node("%ValueDown")

onready var value_total = get_node("%ValueTotal")

onready var ambi_volumes = {
	"left"	: value_left,
	"right"	: value_right,
	"front"	: value_front,
	"back"	: value_back,
	"up"	: value_up,
	"down"	: value_down,
}

onready var ambi = {
	"left"	: get_node("%left"),
	"right"	: get_node("%right"),
	"front"	: get_node("%front"),
	"back"	: get_node("%back"),
	"up"	: get_node("%up"),
	"down"	: get_node("%down"),
}

func _ready():
	OS.center_window()
	#Pause.pauseGame()
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _process(_delta):
	# Display Balance Values
	left_right_value.text = String(left_right_balance.value)
	front_back_value.text = String(front_back_balance.value)
	up_down_value.text    = String(up_down_balance.value)
	
	# Get direction
	var position = Vector3(left_right_balance.value, front_back_balance.value, up_down_balance.value)
	var direction = Vector3.ZERO.direction_to(position)
	
	# Set busses
	value_left.value  = direction.x * -1.0
	visualizer_left.value = value_left.value
	value_right.value = direction.x
	visualizer_right.value = value_right.value
	
	value_front.value  = direction.y * -1.0
	visualizer_front.value = value_front.value
	value_back.value = direction.y
	visualizer_back.value = value_back.value
	
	value_up.value  = direction.z * -1.0
	visualizer_up.value = value_up.value
	value_down.value = direction.z
	visualizer_down.value = value_down.value

	value_total.value = value_left.value + value_right.value + value_front.value + value_back.value + value_up.value + value_down.value
	
	set_ambi_volume()
	
	if auto:
		left_right_balance.value = sin(Time.get_ticks_msec()/2000.0)
		front_back_balance.value = cos(Time.get_ticks_msec()/2000.0)
		
	
func set_ambi_volume():
	ambi.left.volume_db 	= lerp(-40.0, volume+6.0, ambi_volumes.left.value)
	ambi.right.volume_db 	= lerp(-40.0, volume+6.0, ambi_volumes.right.value)
	ambi.front.volume_db 	= lerp(-40.0, volume, ambi_volumes.front.value)
	ambi.back.volume_db 	= lerp(-40.0, volume, ambi_volumes.back.value)
	ambi.up.volume_db 		= lerp(-40.0, volume, ambi_volumes.up.value)
	ambi.down.volume_db 	= lerp(-40.0, volume, ambi_volumes.down.value)


func _on_CheckButton2_toggled(button_pressed):
	auto = button_pressed
