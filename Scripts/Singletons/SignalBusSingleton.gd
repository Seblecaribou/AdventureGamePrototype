extends Node

signal updated_quests(emitter : Node, active_quests : Array[QuestData], FinishedQuests : Array[QuestData])
signal interacted(emitter : Node, interaction_data : InteractableData, interaction_type : String)
signal newstate(emitter : Node, previous_state : String, new_state : String)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

