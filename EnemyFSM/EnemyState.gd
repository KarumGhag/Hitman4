extends Node

class_name EnemyState

@export var chaseState : ChaseState

var nextState : EnemyState = null
@export var body : CharacterBody2D

@export var lineOFSight : RayCast2D

var player : Player
var nav : NavigationAgent2D


#Movement stats
var direction : Vector2 = Vector2.ZERO
@export var speed : float = 300
@export var accel : float = 0.08

var steering : Vector2
var mass : float = 100

var velocity : Vector2
var global_position : Vector2


func onExit() -> void:
	pass

func onEnter() -> void:
	pass
	
func state_process(_delta) -> void:
	pass