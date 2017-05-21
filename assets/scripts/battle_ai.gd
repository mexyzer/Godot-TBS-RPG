extends Node
var manager
var friends
var foes
var available
var timer = 30
var endTimer = 30

func start():
	friends = get_friends()
	available = [] + friends
	
	Console.show(Console.AI, "AI starts its play!")
	Console.show(Console.AI, "Friends alive: " + str(friends.size()))
	
	make_decision()

func make_decision():
	foes = get_foes()
	Console.show(Console.AI, "Foes alive: " + str(foes.size()))
	
	if foes.size() == 0:
		set_process(true)
		endTimer = 30
		return
	
	#available = get_available_friends()
	if available.size() <= 0:
		set_process(true)
		endTimer = 30
		return
	
	available.back().ai_make_decision(self)
	available.pop_back()

func _process(dt):
	if endTimer <= 0:
		manager.activate(true)
		manager.set_turn(0)
		set_process(false)
		Console.show(Console.AI, "X MARKS THE SPOT ------------------------")
	else:
		endTimer -= 1

func get_friends():
	
	var _f = []
	
	for actor in manager.scene.get_actors():
		if actor.group == 1:
			_f.append(actor)
	
	return _f

func get_foes():
	
	var _f = []
	
	for actor in manager.scene.get_actors():
		if actor.group != 1:
			_f.append(actor)
	
	return _f

func do_shit(actor):
	actor.act()

#func get_available_friends():
#	return availableFriends