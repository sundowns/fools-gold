extends Node

var levels = [
#	"res://world/levels/E1M1.tscn",
	"res://world/levels/Temple1.tscn",
	"res://world/levels/Valley1.tscn",
	"res://world/levels/Market.tscn",
	"res://world/levels/Desert.tscn",
#	"res://world/levels/Temple2.tscn",
]
var level_index = -1

signal level_complete
signal all_levels_complete
signal level_restarted

func level_completed():
	emit_signal("level_complete")

func level_restarted():
	emit_signal("level_restarted")

func get_current_level() -> Resource:
	return load(levels[level_index])

func get_next_level() -> Resource:
	level_index += 1
	if level_index + 1 > levels.size():
		emit_signal("all_levels_complete")
		return null
	
	return load(levels[level_index])
