extends Position2D

export var name_anim_rune : String = ""

func _ready() -> void:
	$EnemyBuffalo._name_anim_rune = name_anim_rune

func _on_EnemyBuffalo_tree_exited() -> void:
	$AllyBuffalo.visible = true
