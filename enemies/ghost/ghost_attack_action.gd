extends EnemyAction

@export var damage := 7


func perform_action() -> void: 
	if not enemy or not targets:
		return 
		
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT * 32
	var target_array: Array[Node] = [target]
