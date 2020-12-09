extends Node

var unlocks: Dictionary = {
	"revolver": true,
	"shotgun": false,
	"dual_revolvers": true
}

signal unlocked_weapon(weapon_key)

func unlock(key: String):
	if unlocks.has(key) and unlocks[key] == false:
		unlocks[key] = true
		emit_signal("unlocked_weapon", key)
	else:
		print("tried to unlock imaginary or already unlocked weapon %s" % key)
