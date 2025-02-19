#SignalBusSingleton.gd
extends Node

#QuestManager
##Emitters: QuestManager 
##Connected: DialogueManager
signal update_all_quests(emitter : Node, active_quests : Array[QuestData], finished_quests : Array[QuestData])

##Emitters: PlayerCharacter/InteractNodes/InteractionComponent 
##Connected: QuestManager
signal update_one_quest(emitter : Node, objective_id : String)

##Emitters: PlayerCharacter/InteractNodes/InteractionComponent
##Connected: QuestManager
signal unlock_quest(emitter : Node, quest_id : String)

##Emitters: QuestManager
##Connected: DialogueManager
signal objectives(emitter : Node, objectives : Array[String])

##Emitters: Interactable
##Connected: QuestManager
signal goal_validated(emitter : Node, goal_id : String)

#Interaction
##Emitters: InteractionComponent
##Connected: DialogueManager, GameStateMachine, InventoryManager, QuestManager
signal interacted(emitter : Node, interactable : Interactable, interaction_type : String, player_position : Vector2, goal_id : String)

##Emitters: PlayerCharacter
##Connected: RoomComponent
signal transitioned_area(emitter: Node, is_back: bool, player_z : int, transition_area_name : String)

#StateMachine
##Emitters: PlayerCharacter, DialogueButtonManager, InventoryManager
##Connected: StateMachineComponent
signal newstate_query(emitter : Node, state_machine_name : String, newstate_query : String)

##Emitters: StateMachineComponent (emitter), GameStateMachine (inherits emitter), PlayerStateMachine (inherits emitter)
##Connected: PlayerCharacter, DialogueManager, InventoryManager
signal newstate(emitter : Node, previous_state : String, new_state : String)

#Dialogues
##Emitters: DialogueButtonManager
##Connected: DialogueManager
signal dialogue_button_pressed(emitter : DialogueButtonManager)

#Menus
#Inventory
##Emitters: RadialButtonManager
##Connected: InventoryManager
signal radial_button_pressed(emitter : RadialButtonManager)

##Emitters: InventoryManager
##Connected: PlayerCharacter
signal new_selected_item(emitter : Node, item_id : String)
