extends AudioStreamPlayer3D

onready var base_unit_db = unit_db

func _ready():
# warning-ignore:return_value_discarded
	Global.connect("volume_changed", self, "_on_volume_changed")
	unit_db = linear2db(db2linear(base_unit_db) * (Global.master_volume * Global.sfx_volume))

func _on_volume_changed(master_vol, sfx_vol, _music_vol):
	unit_db = linear2db(db2linear(base_unit_db) * (master_vol * sfx_vol)) 
	
	
