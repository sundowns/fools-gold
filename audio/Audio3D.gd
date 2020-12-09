extends AudioStreamPlayer3D

export(bool) var is_sfx = true
onready var base_unit_db = unit_db

func _ready():
# warning-ignore:return_value_discarded
	Global.connect("volume_changed", self, "_on_volume_changed")
	if is_sfx:
		unit_db = linear2db(db2linear(base_unit_db) * (Global.master_volume * Global.sfx_volume))
	else:
		unit_db = linear2db(db2linear(base_unit_db) * (Global.master_volume * Global.music_volume))

func _on_volume_changed(master_vol, sfx_vol, music_vol):
	if is_sfx:
		unit_db = linear2db(db2linear(base_unit_db) * (master_vol * sfx_vol)) 
	else:
		unit_db = linear2db(db2linear(base_unit_db) * (master_vol * music_vol)) 
	
	
