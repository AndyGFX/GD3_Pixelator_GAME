
extends Node


# ---------------------------------------------------------
# Save to JSON file
# ---------------------------------------------------------
func SaveJSON(path,data):
	
	# Open the existing save file or create a new one in write mode
	var save_file = File.new()
	save_file.open(path, File.WRITE)

	# converts to a JSON string. We store it in the save_file
	save_file.store_line(to_json(data))
	
	# The change is automatically saved, so we close the file
	save_file.close()
		
	pass

# ---------------------------------------------------------
# Load from JSON file
# ---------------------------------------------------------
func LoadJSON(path):
	var load_file = File.new()
	load_file.open(path, File.READ)
	return parse_json(load_file.get_as_text())	
	pass	


func CreateTimer(wait_time, target, method, start):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", target, method)
	add_child(timer)
	if start: timer.start()
	return timer
	pass 
	
func FindNode(node_name):
	return get_tree().get_root().find_node(node_name, true, false)
	
func GetSceneRoot():
	return get_tree().get_root()	

func Instantiate(object,pos):
	var _instance = object.instance()
	_instance.set_position(pos)
	Utils.FindNode("Container").add_child(_instance)
	return _instance
