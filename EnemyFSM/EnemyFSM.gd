extends Node2D

class_name EnemyFSM

@export var currentState : EnemyState

func _ready():
    currentState.onEnter()

func _process(delta) -> void:
    currentState.state_process(delta)
    if currentState.nextState != null:
        changeState(currentState.newState)

func changeState(newState) -> void:
    if currentState != null:
        currentState.newState = null
        currentState.onExit()

    currentState = newState
    currentState.onEnter()
