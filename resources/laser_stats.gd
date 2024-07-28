class_name LaserStats extends Resource

const MIN_COLLISION_LAYER := 1
const MAX_COLLISION_LAYER := 32

@export var damage := 0
@export var color := Color()
@export var speed := 500
@export_flags_2d_physics var collision_layer:int
@export_flags_2d_physics var collision_mask:int
