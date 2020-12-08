extends AudioStreamPlayer3D

onready var base_unit_db = unit_db

func _ready():
# warning-ignore:return_value_discarded
	Global.connect("master_volume_changed", self, "_on_master_volume_changed")

func _on_master_volume_changed(val):
	unit_db = linear2db(db2linear(base_unit_db) * val)
