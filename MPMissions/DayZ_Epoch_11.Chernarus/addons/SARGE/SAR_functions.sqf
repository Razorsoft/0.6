
SAR_commentator = {
   
private ["_unitpos","_group","_speaker"];
_unitpos = [2004.83,12880.6,0.002];
_group = createGroup west;
_group setVariable ["SAR_protect",true,true];
_speaker = _group createunit ["Survivor3_DZ", [(_unitpos select 0) , _unitpos select 1, 0], [], 0.5, "NONE"];
_speaker setVehicleVarname "The_Observer";
_speaker allowDamage false;
_speaker disableAI "FSM";
_speaker disableAI "MOVE";
removeAllWeapons _speaker;
_speaker removeweapon "ItemMap";
_speaker removeweapon "ItemCompass";
_speaker addWeapon "ItemRadio";
SAR_speaker = _speaker;
publicVariable "SAR_speaker";
};
SAR_get_road_pos = {
private ["_targetPosTemp","_newpos","_loop2","_tries2","_roads","_area_name","_centerpos","_centerX","_centerY","_areasize","_rangeX","_rangeY","_areadir","_cosdir","_sindir"];
_area_name = _this select 0;
_centerpos = getMarkerPos _area_name;
_centerX = abs(_centerpos select 0);
_centerY = abs(_centerpos select 1);
_areasize = getMarkerSize _area_name;
_rangeX = _areasize select 0;
_rangeY = _areasize select 1;
_areadir = (markerDir _area_name) * -1;
_cosdir=cos(_areadir);
_sindir=sin(_areadir);
_tries2=0;
_loop2 = false;
while {(!_loop2) && (_tries2 <100)} do {
_tries2=_tries2+1;
_targetPosTemp = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
_roads = (_targetPosTemp nearRoads 50); 
if ((count _roads) > 0) then {
_targetPosTemp = getpos (_roads select 0);
_newpos = _targetPosTemp;
_loop2 = TRUE;
};	
sleep 0.05;	
};	
_newpos;
};
SAR_break_circle = {
private ["_group"];
_group = _this select 0;
_group setBehaviour "AWARE";
{
_x enableAI "TARGET";
_x forceSpeed 1; 
} foreach units _group;
};
SAR_AI_debug = {
private ["_obj","_sp_fightmode","_sp_combatmode","_fightmode","_combatmode","_obj_text_string","_behaviour","_sp_behaviour"];
if (!isServer) exitWith {}; 
_obj = _this select 0;
_sp_fightmode = createvehicle ["Sign_sphere25cm_EP1",getPos _obj,[],0,"NONE"];
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",0,0,0,1];
[nil,nil,rSETOBJECTTEXTURE,_sp_fightmode,0,_obj_text_string] call RE;
sleep 0.5;
_sp_fightmode allowDamage false;
_sp_fightmode attachTo [_obj,[0,0,3]];
_sp_combatmode = createvehicle ["Sign_sphere25cm_EP1",getPos _obj,[],0,"NONE"];
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",0,0,0,1];
[nil,nil,rSETOBJECTTEXTURE,_sp_combatmode,0,_obj_text_string] call RE;  
sleep 0.5;
_sp_combatmode allowDamage false;
_sp_combatmode attachTo [_obj,[0,0,4]];
_sp_behaviour = createvehicle ["Sign_sphere25cm_EP1",getPos _obj,[],0,"NONE"];
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",0,0,0,1];
[nil,nil,rSETOBJECTTEXTURE,_sp_behaviour,0,_obj_text_string] call RE;  
sleep 0.5;
_sp_behaviour allowDamage false;
_sp_behaviour attachTo [_obj,[0,0,5]];
while {alive _obj} do {
_fightmode = _obj getVariable ["SAR_fightmode","not defined"];
switch (_fightmode) do 
{
case "walk":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",0,1,0,1];
};
case "fight":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",1,0,0,1];
};
case "not defined":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",0,0,0,1];
};
};
[nil,nil,rSETOBJECTTEXTURE,_sp_fightmode,0,_obj_text_string] call RE;
sleep .5;
_combatmode = combatMode _obj;
switch (_combatmode) do
{
case "RED":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",1,0,0,1];
};
case "YELLOW":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",1,1,0,1];
};
case "WHITE":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",1,1,1,1];
};
case "GREEN":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",0,1,0,1];
};
case "BLUE":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",0,0,1,1];
};
};
[nil,nil,rSETOBJECTTEXTURE,_sp_combatmode,0,_obj_text_string] call RE;
_behaviour = behaviour _obj;
switch (_behaviour) do
{
case "COMBAT":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",1,0,0,1];
};
case "AWARE":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",1,1,0,1];
};
case "SAFE":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",1,1,1,1];
};
case "CARELESS":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",0,1,0,1];
};
case "STEALTH":
{
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",0,0,1,1];
};
};
[nil,nil,rSETOBJECTTEXTURE,_sp_behaviour,0,_obj_text_string] call RE;
sleep 2;
};
deleteVehicle _sp_fightmode;
deleteVehicle _sp_combatmode;
deleteVehicle _sp_behaviour;
};
SAR_move_to_circle_pos = {
private ["_unit","_centerpos","_newpos","_viewangle","_defend"];
_unit = _this select 0;
_centerpos = _this select 1;
_newpos = _this select 2;
_viewangle = _this select 3;
_defend = _this select 4;
_unit forceSpeed 1;
_unit moveTo _newpos;
_unit doMove _newpos;
waituntil {moveToCompleted _unit};
_unit forceSpeed 0;
_unit setDir _viewangle; 
_unit setpos getPos _unit;
if(!_defend) then {
_unit playActionNow "SitDown";
sleep 1;
} else{
_unit setUnitPos "Middle";
sleep 1;
};
_unit disableAI "TARGET";
};
SAR_circle_static = {
   
private ["_center","_defend","_veh","_angle","_dir","_newpos","_forEachIndex","_leader","_action","_grp","_pos","_units","_count","_viewangle","_radius"];
_count = 0;
  
_leader = _this select 0;
_action = _this select 1;
_radius = _this select 2;
_grp = group _leader;
_defend = false;
_units = units _grp;
_count = count _units;
if(_count > 1) then {  
_pos = getposASL _leader; 
_pos = (_leader) modelToWorld[0,0,0];
doStop _leader;
sleep .5;
_leader playAction "gestureFreeze";
sleep 2;
if(_action == "defend") then {
_center = _leader;
_leader forceSpeed 0;
_defend = true;
};
if(_action == "campfire") then {
_veh = createvehicle["Land_Campfire_burning",_pos,[],0,"NONE"];
_center = _veh;
};
if(_defend) then {
_angle = 360/(_count-1);
}else{
_angle = 360/(_count);
};
_grp enableGunLights true;
_grp setBehaviour "CARELESS";
{
if(_x != _leader || {_x == _leader && !_defend}) then { 
_newpos = (_center modelToWorld [(sin (_forEachIndex * _angle))*_radius, (cos (_forEachIndex *_angle))*_radius, 0]);
if(_defend) then {
_dir = 0;
}else{
_dir = 180;
};
_viewangle = (_foreachIndex * _angle) + _dir;
[_x,_pos,_newpos,_viewangle,_defend]spawn SAR_move_to_circle_pos;
};
} foreach _units;
};
};
SAR_fnc_selectRandom = {
private ["_ret"];
_ret = count _this;   
_ret = floor (random _ret);   
_ret = _this select _ret; 
_ret;
};
SAR_isKindOf_weapon = {
private ["_class","_weapon","_cfg_entry","_found","_search_class"];
_weapon = _this select 0;
_class = _this select 1;
_cfg_entry = configFile >> "CfgWeapons" >> _weapon;
_search_class = configFile >> "CfgWeapons" >> _class;
_found = false;
while {isClass _cfg_entry} do
{
if (_cfg_entry == _search_class) exitWith { _found = true; };
_cfg_entry = inheritsFrom _cfg_entry;
};
_found;
};
SAR_veh_side_debug = {
private["_vehicle","_sphere","_side","_sphere_red","_sphere_alpha","_sphere_green","_sphere_blue","_obj_text_string"];
_vehicle = _this select 0;
_sphere = _vehicle getVariable ["SAR_sphere_side_id",objNull];
while {true} do {
_side = side _vehicle;
switch (_side) do 
{
case sideEnemy:
{
_sphere_red = 1;
_sphere_green= 1;
_sphere_blue=0;
};
case west:
{
_sphere_red = 0;
_sphere_green= 0;
_sphere_blue=1;
};
case east:
{
_sphere_red = 1;
_sphere_green= 0;
_sphere_blue=0;
};
case civilian:
{
_sphere_red = 1;
_sphere_green= 1;
_sphere_blue=1;
};
case resistance:
{
_sphere_red = 0;
_sphere_green= 1;
_sphere_blue=0;
};
default
{
_sphere_red = 0;
_sphere_green= 0;
_sphere_blue=0;
};
};
_sphere_alpha = 1;
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",_sphere_red,_sphere_green,_sphere_blue,_sphere_alpha];
[nil,nil,rSETOBJECTTEXTURE,_sphere,0,_obj_text_string] call RE;
sleep 5;
};
};
SAR_AI_veh_trig_on_static = {
private ["_unit_list","_unitlist","_trigger","_triggername","_player_joined","_player_left","_trig_unitlist","_units_leaving","_player_rating","_clientmachine","_sphere_alpha","_sphere_red","_sphere_green","_sphere_blue","_obj_text_string","_vehicle","_sphere"];
if(!isServer) exitWith {};
if(SAR_EXTREME_DEBUG) then {
diag_log "SAR_EXTREME_DEBUG: Vehicle FIX:";
diag_log "SAR_EXTREME_DEBUG: Vehicle FIX: -- Trigger activated, Script started ...";
diag_log "SAR_EXTREME_DEBUG: Vehicle FIX:";
};
_unit_list = _this select 0;
_trigger = _this select 1;
_triggername = _this select 2;
_unitlist=[];
_vehicle = _trigger getVariable ["SAR_trig_veh",objNull];
_sphere = _vehicle getVariable ["SAR_sphere_id",objNull];
if(SAR_EXTREME_DEBUG) then {
diag_log format["SAR_EXTREME_DEBUG: Vehicle FIX: Trigger: %1 at vehicle: %3, location %2 was activated or deactivated!",_triggername,getpos _trigger,typeof _vehicle];
};
{
if (isPlayer _x) then {
_unitlist set[count _unitlist,_x]; 
};
} foreach _unit_list;
_trig_unitlist = _trigger getVariable["unitlist",[]];
if(count _unitlist > count _trig_unitlist) then {
if(SAR_EXTREME_DEBUG) then {diag_log format["SAR_EXTREME_DEBUG: Vehicle FIX: someone entered the vehicle area of a %1",typeof _vehicle];};
_player_joined = _unitlist select ((count _unitlist) -1);
if(SAR_EXTREME_DEBUG) then {
diag_log format["SAR_EXTREME_DEBUG: Vehicle FIX: Player entered trigger area, name is: %1",_player_joined];
_sphere_alpha = 1;
_sphere_red = 1;
_sphere_green= 0;
_sphere_blue=0;
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",_sphere_red,_sphere_green,_sphere_blue,_sphere_alpha];
[nil,nil,rSETOBJECTTEXTURE,_sphere,0,_obj_text_string] call RE;
};
_player_rating = rating _player_joined;
if (_player_rating < 0) then {
_player_joined setVariable ["SAR_rating",_player_rating,true];
adjustrating = [_player_joined,(0 - _player_rating)];
_clientmachine = owner _player_joined;
_clientmachine publicVariableClient "adjustrating";
};
_trig_unitlist set [count _trig_unitlist, _player_joined];
_trigger setVariable ["unitlist",_trig_unitlist,true];
if(SAR_EXTREME_DEBUG) then {
diag_log "SAR_EXTREME_DEBUG: Vehicle FIX:";
diag_log "SAR_EXTREME_DEBUG: Vehicle FIX: Logic for trigger activation finished";
diag_log "SAR_EXTREME_DEBUG: Vehicle FIX:";
}; 
} else { 
if(SAR_EXTREME_DEBUG) then {diag_log "SAR_EXTREME_DEBUG: Vehicle FIX: someone left the vehicle area";}; 
_units_leaving =  _trig_unitlist - _unitlist;
_player_left = _units_leaving select 0;
if(SAR_EXTREME_DEBUG) then {
diag_log format["SAR_EXTREME_DEBUG: Vehicle FIX: Player left, name is: %1",_player_left];
_sphere_alpha = 1;
_sphere_red = 0;
_sphere_green= 1;
_sphere_blue=0;
_obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",_sphere_red,_sphere_green,_sphere_blue,_sphere_alpha];
[nil,nil,rSETOBJECTTEXTURE,_sphere,0,_obj_text_string] call RE;
};
if (count _unitlist == 0) then {
_trigger setVariable ["unitlist",[],true]; 
} else {
  _trigger setVariable ["unitlist",_unitlist,true]; 
};
_player_rating = rating _player_left;
if(_player_rating == 0) then {
_player_rating = _player_left getVariable ["SAR_rating",0];
adjustrating = [_player_left,(0 + _player_rating)];
_clientmachine = owner _player_left;
_clientmachine publicVariableClient "adjustrating";
};
if(SAR_EXTREME_DEBUG) then {
diag_log "SAR_EXTREME_DEBUG: Vehicle FIX:";
diag_log "SAR_EXTREME_DEBUG: Vehicle FIX: Logic for trigger deactivation finished";
diag_log "SAR_EXTREME_DEBUG: Vehicle FIX:";
};
};
if(SAR_EXTREME_DEBUG) then {
diag_log "SAR_EXTREME_DEBUG: Vehicle FIX:";
diag_log "SAR_EXTREME_DEBUG: Vehicle FIX: -- end of vehicle fix logic.";
diag_log "SAR_EXTREME_DEBUG: Vehicle FIX:";
};
};
SAR_AI_veh_trig_off = {
};
SAR_AI_is_unfriendly_group = {
private ["_trig_player_list","_bandits_in_trigger","_player_humanity"];
_trig_player_list = _this select 0;
_bandits_in_trigger = false;
{
_player_humanity = _x getVariable ["humanity",0];
if(_player_humanity < SAR_HUMANITY_HOSTILE_LIMIT) then {
_bandits_in_trigger = true;
};
} foreach _trig_player_list;
_bandits_in_trigger;
};
SAR_debug_array = {
private ["_array","_foreachIndex","_name"];
_array = _this select 0;
_name = _this select 1;
diag_log " ";
diag_log format["SAR_DEBUG: Array contents of %1 --------",_name];
diag_log " ";
{
diag_log format["%1. entry:  %2",_foreachIndex,_x];
} foreach _array;
diag_log " ";
diag_log "SAR_DEBUG: Array contents ----------- end   ----------";
diag_log " ";
};
SAR_log = {
private ["_loglevel","_values","_descs","_logstring","_resultstring","_forEachIndex","_percstring","_finalstring","_resultstring"];
_loglevel = _this select 0;
_descs = _this select 1;
_values = _this select 2;
switch (_loglevel) do {
case 0:
{
_logstring = "SAR_DEBUG: ";
};
case 1:
{
_logstring = "SAR_EXTREME_DEBUG: ";
};
};
{
_logstring = _logstring + _descs select _forEachIndex;
if(_forEachIndex < (count _values) - 1) then {_logstring = _logstring + "|";};
_resultstring = _resultstring + _values select _forEachIndex;
_percstring = _percstring + "%" + str(_forEachIndex + 1) + " ";
 
if(_forEachIndex < (count _values) - 1) then {_resultstring = _resultstring + ",";};
} foreach _values;
_finalstring = "diag_log format[" + _logstring + _percstring +"," + _resultstring + "];";
Call Compile Format ["%1",_finalstring];
};
KRON_StrToArray = {
	private ["_in","_arr","_out"];
	_in=_this select 0;
	_arr = toArray(_in);
	_out=[];
	for "_i" from 0 to (count _arr)-1 do {
		_out=_out+[toString([_arr select _i])];
	};
	_out
};
KRON_StrLeft = {
	private["_in","_len","_arr","_out"];
	_in=_this select 0;
	_len=(_this select 1)-1;
	_arr=[_in] call KRON_StrToArray;
	_out="";
	if (_len>=(count _arr)) then {
		_out=_in;
	} else {
		for "_i" from 0 to _len do {
			_out=_out + (_arr select _i);
		};
	};
	_out
};
SAR_unit_loadout_tools = {
private ["_unittype","_side","_unit_tools_list","_unit_tools","_tool","_probability","_chance"];
_unittype = _this select 0;
_side = _this select 1;
_unit_tools_list = call compile format["SAR_%2_%1_tools",_unittype,_side];
_unit_tools = [];
{
_tool = _x select 0;
_probability = _x select 1;
_chance = (random 100);
if(_chance < _probability) then {
_unit_tools set [count _unit_tools, _tool];
};
} foreach _unit_tools_list;
_unit_tools;
};
SAR_unit_loadout_items = {
private ["_unittype","_unit_items_list","_unit_items","_item","_probability","_chance","_side"];
_unittype = _this select 0;
_side = _this select 1;
_unit_items_list = call compile format["SAR_%2_%1_items",_unittype,_side];
_unit_items = [];
{
_item = _x select 0;
_probability = _x select 1;
_chance = (random 100);
if(_chance < _probability) then {
_unit_items set [count _unit_items, _item];
};
} foreach _unit_items_list;
_unit_items;
};
SAR_unit_loadout_weapons = {
private ["_unittype","_side","_unit_weapon_list","_unit_pistol_list","_unit_pistol_name","_unit_weapon_name","_unit_weapon_names"];
_unittype = _this select 0;
_side = _this select 1;
_unit_weapon_list = call compile format["SAR_%2_%1_weapon_list",_unittype,_side];
_unit_pistol_list = call compile format["SAR_%2_%1_pistol_list",_unittype,_side];
_unit_weapon_names = [];
_unit_weapon_name = "";
_unit_pistol_name = "";
if(count _unit_weapon_list > 0) then {
_unit_weapon_name = _unit_weapon_list select (floor(random (count _unit_weapon_list)));
};
if(count _unit_pistol_list > 0) then {
_unit_pistol_name = _unit_pistol_list select (floor(random (count _unit_pistol_list)));
};
_unit_weapon_names set [0, _unit_weapon_name];
_unit_weapon_names set [1, _unit_pistol_name];
_unit_weapon_names;
};
SAR_unit_loadout = {
private ["_unit","_weapons","_weapon","_items","_unit_magazine_name","_item","_tool","_tools","_forEachIndex"];
_unit = _this select 0;
_weapons = _this select 1;
_items = _this select 2;
_tools = _this select 3;
removeAllWeapons _unit;
_unit removeweapon "ItemMap";
_unit removeweapon "ItemCompass";
_unit removeweapon "ItemRadio";
{
_weapon = _weapons select _forEachIndex;
if (_weapon !="") then
{
_unit_magazine_name = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
_unit addMagazine _unit_magazine_name;
_unit addWeapon _weapon;
};
} foreach _weapons;
{
_item = _items select _forEachIndex;
_unit addMagazine _item;
} foreach _items;
{
_tool = _tools select _forEachIndex;
_unit addWeapon _tool;
} foreach _tools;
};
SAR_AI_mon_upd = {
private ["_typearray","_valuearray","_gridname","_path","_success","_forEachIndex"];
_typearray = _this select 0;
_valuearray =_this select 1;
_gridname = _this select 2;
_path = [SAR_AI_monitor, _gridname] call BIS_fnc_findNestedElement;
{
switch (_x) do 
{
case "max_grps":
{
_path set [1,1];
};
case "rnd_grps":
{
_path set [1,2];
};
case "max_p_grp":
{
_path set [1,3];
};
case "grps_band":
{
_path set [1,4];
};
case "grps_sold":
{
_path set [1,5];
};
case "grps_surv":
{
_path set [1,6];
};
};
_success = [SAR_AI_monitor, _path, _valuearray select _forEachIndex] call BIS_fnc_setNestedElement;
}foreach _typearray;
_success;
};
SAR_AI_mon_read = {
private ["_typearray","_gridname","_path","_resultarray"];
_typearray = _this select 0;
_gridname = _this select 1;
_resultarray=[];
_path = [SAR_AI_monitor, _gridname] call BIS_fnc_findNestedElement;
{
switch (_x) do 
{
case "max_grps":
{
_path set [1,1];
};
case "rnd_grps":
{
_path set [1,2];
};
case "max_p_grp":
{
_path set [1,3];
};
case "grps_band":
{
_path set [1,4];
};
case "grps_sold":
{
_path set [1,5];
};
case "grps_surv":
{
_path set [1,6];
};
};
_resultarray set[count _resultarray,[SAR_AI_monitor, _path ] call BIS_fnc_returnNestedElement];
}foreach _typearray;
_resultarray;
};
SAR_DEBUG_mon = {
diag_log "--------------------Start of AI monitor values -------------------------";
{
diag_log format["SAR EXTREME DEBUG: %1",_x];
}foreach SAR_AI_monitor;
diag_log "--------------------End of AI monitor values   -------------------------";
};
SAR_fnc_returnConfigEntry = {
	private ["_config", "_entryName","_entry", "_value"];
	_config = _this select 0;
	_entryName = _this select 1;
	_entry = _config >> _entryName;
	
	if (((configName (_config >> _entryName)) == "") && {!((configName _config) in ["CfgVehicles", "CfgWeapons", ""])}) then {
		[inheritsFrom _config, _entryName] call SAR_fnc_returnConfigEntry;
	}
	else { if (isNumber _entry) then { _value = getNumber _entry; } else { if (isText _entry) then { _value = getText _entry; }; }; };
	
	if (isNil "_value") exitWith {nil};
	_value;
};
SAR_fnc_returnVehicleTurrets = {
	private ["_entry","_turrets","_turretIndex"];
	_entry = _this select 0;
	_turrets = [];
	_turretIndex = 0;
	
	for "_i" from 0 to ((count _entry) - 1) do {
		private ["_subEntry"];
		_subEntry = _entry select _i;
		if (isClass _subEntry) then {
			private ["_hasGunner"];
			_hasGunner = [_subEntry, "hasGunner"] call SAR_fnc_returnConfigEntry;
			
			if (!(isNil "_hasGunner")) then {
				if (_hasGunner == 1) then {
					_turrets = _turrets + [_turretIndex];
					
					if (isClass (_subEntry >> "Turrets")) then { _turrets = _turrets + [[_subEntry >> "Turrets"] call SAR_fnc_returnVehicleTurrets]; }
					else { _turrets = _turrets + [[]]; };
				};
			};
			_turretIndex = _turretIndex + 1;
		};
		sleep 0.01;
	};
	_turrets;
};
