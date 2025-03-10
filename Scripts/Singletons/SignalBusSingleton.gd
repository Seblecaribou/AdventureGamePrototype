#SignalBusSingleton.gd
extends Node

#region QuestManager
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
#endregion


#region Interaction
##Emitters: InteractionComponent
##Connected: DialogueManager, GameStateMachine, InventoryManager, QuestManager
signal interacted(emitter : Node, interactable : Interactable, interaction_type : String, player_position : Vector2, goal_id : String)

##Emitters: InteractionComponent
##Connected: CameraManager, MovementComponent
signal room_changed(emitter : Node, top_limit : float, left_limit : float, bottom_limit : float, right_limit : float)

##Emitters: InteractionComponent
##Connected: PlayerCharacter
signal in_teleport_entrance(emitter : Node, entrance_node : Node)
#endregion

#region PlayerCharacter
##Emitters: PlayerCharacter
##Connected: CameraManager, MovementComponent, RoomComponent, PlayerCharacter
signal teleported(emitter : Node, player_z : int, arrival_area : String, arrival_area_data : Dictionary, arrival_node : CollisionShape2D)

##Emitters: PlayerCharacter
##Connected: RoomComponent
signal transitioned_area(emitter: Node, is_back: bool, player_z : int, transition_area_name : String)
#endregion

#region StateMachine
##Emitters: PlayerCharacter, DialogueButtonManager, InventoryManager
##Connected: StateMachineComponent
signal newstate_query(emitter : Node, state_machine_name : String, newstate_query : String)

##Emitters: StateMachineComponent (emitter), GameStateMachine (inherits emitter), PlayerStateMachine (inherits emitter)
##Connected: PlayerCharacter, DialogueManager, InventoryManager
signal newstate(emitter : Node, previous_state : String, new_state : String)
#endregion

#region Dialogues
##Emitters: DialogueButtonManager
##Connected: DialogueManager
signal dialogue_button_pressed(emitter : DialogueButtonManager)
#endregion

#Menus and UI
#Inventory
##Emitters: RadialButtonManager
##Connected: InventoryManager
signal radial_button_pressed(emitter : RadialButtonManager)

##Emitters: InventoryManager
##Connected: PlayerCharacter
signal new_selected_item(emitter : Node, item_id : String)
