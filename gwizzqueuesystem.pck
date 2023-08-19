GDPC                @                                                                         T   res://.godot/exported/133200997/export-28d74bcfaeb4b0ca75c8bfcbf615d89f-client.scn  �      �      `�>:�����m퇸    P   res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn@      �      ϋ�Te�v��1W����    ,   res://.godot/global_script_class_cache.cfg  �#             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexP      �      �̛�*$q�*�́        res://.godot/uid_cache.bin  �'      V       ��_4�?�I ɑ�9)r�       res://client.gd         {      K��~"��䓦�ˈ"��       res://client.tscn.remap �"      c       ��i�"z��Bg>Gr�q       res://data.gd   `	      �      A�}���z�I�ڶ��       res://icon.svg  �#      �      C��=U���^Qu��U3       res://icon.svg.import   0      �       �մ�҄�Yn.'���       res://main.gd          5      -�����	i�F��W       res://main.tscn.remap   @#      a       �J�Sw� ������       res://project.binary�'      �      �]���|��	��=    q�콛�S�extends Node2D

@onready var cam = $Camera2D
@onready var personal = $personal
@onready var text_edit = $personal/TextEdit
@onready var requests = $personal/Requests

var sent = false

var curData = ""

func _enter_tree():
	set_multiplayer_authority(name.to_int())

# Called when the node enters the scene tree for the first time.
func _ready():
	personal.visible = is_multiplayer_authority()
	cam.enabled = is_multiplayer_authority()
	
	for n in $"../data".data["amnt"]:
		curData += str("Request ", n, ": ", $"../data".data[str("Request: ", n)], "\n")
		requests.text = curData
	
func _on_button_pressed():
	if is_multiplayer_authority():
		rpc("sendData", text_edit.text, sent)
		$"../data".data[str("Request: ",$"../data".data["amnt"])] = text_edit.text
		curData += str("Request ", $"../data".data["amnt"], ": ", $"../data".data[str("Request: ", $"../data".data["amnt"])], "\n")
		requests.text = curData
		sent = true


@rpc("any_peer","call_local") func sendData(data,s):
	if !is_multiplayer_authority():
		if !s:
			$"../data".data[str("Request: ",$"../data".data["amnt"])] = data
			$"../data".data["amnt"] += 1
			$"../data".save_game()
  ^X�RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://client.gd ��������      local://PackedScene_84cgb          PackedScene          	         names "         client    script    Node2D 	   personal 	   TextEdit    offset_left    offset_top    offset_right    offset_bottom    placeholder_text    Button    text 	   Requests 	   Camera2D 	   position    _on_button_pressed    pressed    	   variants                      ��     A�     �C     �      Video request      ��     i�     �      Add      a�     ��     �C     �C
     �B  �A      node_count             nodes     J   ��������       ����                            ����                     ����                           	                 
   
   ����                              	                    ����      
                                       ����                   conn_count             conns                                      node_paths              editable_instances              version             RSRCextends Node

var data = {"amnt" : 0}

func _ready():
	load_game()
	print(data)
	
func save():
	var save_dict = data
	return save_dict
	
func save_game():
	var save_game = FileAccess.open_encrypted_with_pass("user://savegame.save", FileAccess.WRITE, "Gwizz")
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)
	
	
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
	
	var save_game = FileAccess.open_encrypted_with_pass("user://savegame.save", FileAccess.READ, "Gwizz")
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		data = node_data
�GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[ �к���u>^�O[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bk57bbxda5mcr"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 h�Y����(�OeG@lextends Node2D

var peer = ENetMultiplayerPeer.new()
@export var playerScene : PackedScene
@onready var cam = $Camera2D

var portNum = 25665

var isServer = false

		
func _on_host_pressed():
	peer.create_server(portNum)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	add_player()
	cam.enabled = false
	$Host.hide()
	$Join.hide()
	isServer = true
	
func _on_join_pressed():
	isServer = false
	peer.create_client("127.0.0.1", portNum)
		
	multiplayer.multiplayer_peer = peer
	cam.enabled = false
	$Host.hide()
	$Join.hide()
	
func add_player(id = 1):
	var player = playerScene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)
	
func del_player(id):
	rpc("_del_player", id)
	
@rpc("any_peer", "call_local") func _del_player(id):
	get_node(str(id)).queue_free()
*{@���9��RSRC                    PackedScene            ��������                                                  ..    resource_local_to_scene    resource_name 	   _bundled    script       Script    res://main.gd ��������   PackedScene    res://client.tscn ��Z�Jj�   Script    res://data.gd ��������      local://PackedScene_o4i4n _         PackedScene          	         names "         main    script    playerScene    Node2D    data    Node 	   Camera2D    zoom    Host    offset_left    offset_top    offset_right    text    Button    Join    offset_bottom    MultiplayerSpawner    _spawnable_scenes    spawn_path    _on_host_pressed    pressed    _on_join_pressed    	   variants                                   
      @   @     ��     ��     �A      HOST      �A      JOIN "         res://client.tscn                 node_count             nodes     F   ��������       ����                                  ����                           ����                           ����   	      
                                    ����   	                     	                     ����      
                   conn_count             conns                                                              node_paths              editable_instances              version             RSRC���tkȫ�[remap]

path="res://.godot/exported/133200997/export-28d74bcfaeb4b0ca75c8bfcbf615d89f-client.scn"
��j���vOڨ{�[remap]

path="res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn"
HOvg�ӚE˖�b�list=Array[Dictionary]([])
[�g�<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
�<�#�M2L��   ��Z�Jj�   res://client.tscn�To�Ͼ+   res://icon.svg>Ce��>D   res://main.tscn����Bا�ECFG      application/config/name         gwizzqueuesystem   application/run/main_scene         res://main.tscn &   application/config/use_custom_user_dir         '   application/config/custom_user_dir_name      
   GwizzQueue     application/config/features$   "         4.1    Forward Plus       application/config/icon         res://icon.svg  #   rendering/renderer/rendering_method         gl_compatibility��M>
C��4b