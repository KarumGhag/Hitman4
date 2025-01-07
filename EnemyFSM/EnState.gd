extends Node

class_name EnemyState

@export var chaseState : ChaseState

var nextState : EnemyState = null
@export var body : CharacterBody2D

@export var lineOFSight : RayCast2D


func onExit() -> void:
	pass

func onEnter() -> void:
	pass
	
func state_process(_delta) -> void:
	pass