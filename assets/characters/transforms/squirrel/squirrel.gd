extends Position2D

export var name_anim_rune : String = ""

func _ready() -> void:
	$EnemySquirrel._name_anim_rune = name_anim_rune

func _on_EnemySquirrel_tree_exited() -> void:
	$AllySquirrel.visible = true
