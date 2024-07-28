# meta-name: Empty State
# meta-description: Creates an empty state machine state component script with all the necessary methods to hook into.
# meta-default: true
extends _BASE_

func enter() -> void:
_TS_pass

func exit() -> void:
_TS_pass

func run_process(delta: float) -> StateMachStateComponent:
_TS_return null

func run_physics_process(delta: float) -> StateMachStateComponent:
_TS_return null

func run_input(event: InputEvent) -> StateMachStateComponent:
_TS_return null
