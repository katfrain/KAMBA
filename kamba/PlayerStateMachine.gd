extends StateMachine

@export var persona_identity: State   # Dynamically updated persona identity
@onready var player: CharacterBody2D = $".."

func _on_persona_entered(identity: State):	
	persona_identity = identity
	animated_sprite.play("Poof")
		
func Poof_Done():
	if animated_sprite.animation == "Poof":	
		current_state.UpdatePersona(persona_identity)
