#AppSettingsSingleton.gd
extends Node

#PATHS
var base_user_path : String = "user://"
var base_res_path : String = "res://"
#DATA
var data_folder_path : String = "Data/"
var characters_data_folder_path : String = "Characters/"
var dialogues_data_folder_path : String = "Dialogues/"
var items_data_folder_path : String = "Items/"
var quests_data_folder_path : String = "Quests/"

#DIALOGUES
var dialogue_menu_offset : Vector2 = Vector2(50 , -10) #Vector2(x_offset, y_offset)
var dialogue_menu_size : Vector2 = Vector2(150 , 250) #Vector2(width, height)
var dialogue_button_size : Vector2 = Vector2(150 , 44) #Vector2(width, height)
var dialogue_menu_spacing : int = 10
