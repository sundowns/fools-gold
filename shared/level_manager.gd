extends Node

var levels = []
var level_index = 0

signal level_complete

func level_completed():
	print('level fin!!')
	emit_signal("level_complete")
