"""
Base interface for all states: it doesn't do anything in itself
but forces us to pass the right arguments to the methods below
and makes sure every State object had all of these methods.
"""
extends Node

class_name State

signal finished(next_state_name)

# Initialize the state. E.g. change the animation
func _enter():
	return

# Clean up the state. Reinitialize values like a timer
func _exit():
	return

func _handle_input(event):
	return

func _update(delta):
	return

func _on_animation_finished(anim_name):
	return