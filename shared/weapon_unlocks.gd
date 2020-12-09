extends Node

var unlocks: Dictionary = {
	"revolver": true,
	"shotgun": false,
	"dual_revolvers": true
}

signal unlocked_weapon(weapon_key)

func unlock(key: String):
	if unlocks.has(key):
		unlocks[key] = true
		print("unlocked: %s" %key)
		emit_signal("unlocked_weapon", key)
	else:
		print("tried to unlock imaginary weapon %s" % key)
