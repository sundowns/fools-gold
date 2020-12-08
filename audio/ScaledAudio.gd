extends AudioStreamPlayer

onready var base_volume_db = volume_db

func _ready():
# warning-ignore:return_value_discarded
	Global.connect("volume_changed", self, "_on_volume_changed")
	volume_db = linear2db(db2linear(base_volume_db) * (Global.master_volume * Global.music_volume))

func _on_volume_changed(master_vol, _sfx_vol, music_vol):
	volume_db = linear2db(db2linear(base_volume_db) * (master_vol * music_vol))
