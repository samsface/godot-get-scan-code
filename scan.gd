extends Reference
class_name DefaultInputMap
const PS_CONTROLLERS = ["Sony DualShock 4", "PS2 Controller", "PS4 Controller", "PS3 Controller", "PS5 Controller", "Sony DualShock 4 V2", "Sony DualShock 4 Wireless Adaptor"]
 
const CONTROLLER_STRINGS = { #0 - PS, 1 - XBOX
	0 : ["Cross","A"],
	1 : ["Circle","B"],
	2 : ["Square","X"],
	3 : ["Triangle","Y"],
	4 : ["L1","LB"],
	5 : ["R1","RB"],
	6 : ["L2 B","LT"],
	7 : ["R2 B","RT"],
	8 : ["L3","L"], #L3 = Left Stick press
	9 : ["R3","R"], #R3  = Left Stick press
	10 : ["Share","Select"],
	11 : ["Options","Start"],
	12 : ["D-Pad Up","D-Pad Up"],
	13 : ["D-Pad Down","D-Pad Down"],
	14 : ["D-Pad Left","D-Pad Left"],
	15 : ["D-Pad Right","D-Pad Right"],
	16 : ["PS Button","Xbox Share"],
	17 : ["","Paddle 1"],
	18 : ["","Paddle 2"],
	19 : ["","Paddle 3"],
	20 : ["","Paddle 4"],
	21 : ["Touchpad",""],
	}
 
const MOTION_STRINGS = {
	0: ["LS Left", "LS Right"],
	1: ["LS Up", "LS Down"],
	2: ["RS Left", "RS Right"],
	3: ["RS Up", "RS Down"],
	6: ["L2","LT"], #is press but Godot reads as motion
	7: ["R2","RT"], #is press but Godot reads as motion
	}
	
const x_ = {
	"xbox": {
		InputEventJoypadButton: {
			0: "a",
			1: "b",
			2: "x",
			3: "y",
			4: "lb",
			5: "rb",
			6: "lt",
			7: "rt",
			8: "l",
			9: "l",
			10: "r",
			11: "start",
			12: "d-pad-up",
			13: "d-pad-down", 
			14: "d-pad-left",
			15: "d-pad-right",
			16: "share"
		},
		InputEventJoypadMotion: {
			0: ["left-stick-left", "left-stick-right"],
			1: ["left-stick-up", "left-stick-down"],
			3: ["right-stick-left", "right-stick-right"],
			4: ["right-stick-up", "right-stick-down"],
			2: ["lt", "lt"], 
			5: ["rt", "rt"], 
			6: ["lt", "lt"],
			7: ["rt", "rt"]
		}
	}
}
const m_ := {
	"a":"À",
	"b":"Á",
	"x":"Â",
	"y":"Ã",
	"lb":"Ä",
	"rb":"Å",
	"lt":"Æ",
	"rt":"Ç",
	"l":"È",
	"r":"É",
	"select":"Ê",
	"start":"Ë",
	"d-pad-up":"Ì",
	"d-pad-down":"Í", 
	"d-pad-left":"Î",
	"d-pad-right":"Ï",
	"right-stick-up":"Ñ^",
	"right-stick-down":"Ñv",
	"right-stick-left":"Ñ<",
	"right-stick-right":"Ñ>",
	"left-stick-up":"Ð^",
	"left-stick-down":"Ðv",
	"left-stick-left":"Ð<",
	"left-stick-right":"Ð>" 
}
static func get_scheme_name(input_event:InputEvent) -> String:
	var device := "mouse_and_keyboard"
	if input_event:
		device = Input.get_joy_name(input_event.device).to_lower()
		if input_event is InputEventJoypadButton or input_event is InputEventJoypadMotion:
			device = "joypad"
		elif input_event is InputEventWithModifiers:
			device = "mouse_and_keyboard"
	return device
static func get_code_string(input_event:InputEvent) -> String:
	var idx = 0
	var type = InputEvent
	var device = Input.get_joy_name(input_event.device).to_lower()
	
	if device.find("xbox") != -1:
		device = "xbox"
	else:
		device = "xbox"
	var axis_idx = 0
	if input_event is InputEventJoypadMotion:
		idx = input_event.axis
		type = InputEventJoypadMotion
		axis_idx = 1 if input_event.axis_value < 0.0 else 0
		
	if input_event is InputEventJoypadButton:
		idx = input_event.button_index
		type = InputEventJoypadButton
	
	if input_event is InputEventKey:
		var s := OS.get_scancode_string(input_event.scancode)
		if s == "Space":
			return "[i] [/i]"
		elif s == "Shift":
			return "[i]+[/i]"
		return "[i]" + s + "[/i]"
	elif input_event is InputEventMouseButton:
		if input_event.button_index == 1:
			return "[i]([/i]"
		elif input_event.button_index == 2:
			return "[i])[/i]"
		elif input_event.button_index == 3:
			return "MMB"
		elif input_event.button_index == 4:
			return "WHEEL UP"
		elif input_event.button_index == 5:
			return "WHEEL DOWN"
	elif input_event is InputEventJoypadButton:
		return "[i]" + m_[x_[device][type][idx]] + "[/i]"
	elif input_event is InputEventJoypadMotion:
		return "[i]" + m_[x_[device][type][idx][axis_idx]] + "[/i]"
	return ""
