#SignalBusSingleton.gd
extends Node

#QuestManager
##Emitters: QuestManager 
##Connected: DialogueManager
signal update_all_quests(emitter : Node, active_quests : Array[QuestData], FinishedQuests : Array[QuestData])

##Emitters: PlayerCharacter/InteractNodes/InteractionComponent 
##Connected: QuestManager
signal update_one_quest(emitter : Node, objective_id : String)

##Emitters: PlayerCharacter/InteractNodes/InteractionComponent
##Connected: QuestManager
signal unlock_quest(emitter : Node, quest_id : String)

#Interaction
signal interacted(emitter : Node, interactable : Interactable, interaction_type : String)

#StateMachine
signal newstate(emitter : Node, previous_state : String, new_state : String)
