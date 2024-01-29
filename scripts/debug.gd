extends PanelContainer

@onready var property_container = %VBoxContainer

#var property
var frames_per_second: String


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.debug = self

	visible = false


func _process(delta):
	if visible:
		# Use delta time to get approx frames per second and round to two decimal places !Disable Vsync if fps is stuck at 60!
		frames_per_second = "%.2f" % (1.0 / delta)
		add_property("FPS", frames_per_second, 2)


func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible


func add_property(title: String, value, order):
	var target
	target = property_container.find_child(title, true, false)  # Try to find Label node with same name
	if !target:
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = title + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		property_container.move_child(target, order)
