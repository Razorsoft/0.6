
bottlerainScript = true;

if (!isDedicated) then {

	"filmic" setToneMappingParams [0.07, 0.31, 0.23, 0.37, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

	BIS_Effects_Burn = 			compile preprocessFile "\ca\Data\ParticleEffects\SCRIPTS\destruction\burn.sqf"; 
	player_zombieCheck = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_zombieCheck.sqf";	
	player_zombieAttack = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_zombieAttack.sqf";	
	fnc_usec_damageActions =	compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageActions.sqf";		
	fnc_inAngleSector =			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_inAngleSector.sqf";		
	
	fnc_usec_selfActions =		compile preprocessFileLineNumbers "Scripts\fn_selfActions.sqf";		
	
	fnc_usec_unconscious =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_unconscious.sqf";
	player_temp_calculation	=	compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_temperatur.sqf";		
	player_weaponFiredNear =	compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_weaponFiredNear.sqf";
	player_animalCheck =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_animalCheck.sqf";
	player_spawnCheck = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_spawnCheck.sqf";
	player_dumpBackpack = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_dumpBackpack.sqf";
	
	
	building_spawnLoot =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\building_spawnLoot.sqf";
	
	building_spawnZombies =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\building_spawnZombies.sqf";
	
	
	player_fired =				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_fired.sqf";			
	player_packTent =			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_packTent.sqf";
	player_packVault =			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_packVault.sqf";
	player_unlockVault =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_unlockVault.sqf";
	
	player_removeObject =		compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\remove.sqf";
	player_removeNet =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\object_removeNet.sqf";

	player_unlockDoor =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_unlockDoor.sqf";
	player_changeCombo =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_changeCombo.sqf";
	
	player_lockVault =			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_lockVault.sqf";
	
	player_updateGui =			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_updateGui.sqf";
	player_crossbowBolt =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_crossbowBolt.sqf";
	spawn_flies = 				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\spawn_flies.sqf";
	
	
	
	player_music = 				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_music.sqf";			
	player_login = 				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_login.sqf";			
	player_death =				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_death.sqf";
	player_switchModel =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_switchModel.sqf";
	player_checkStealth =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_checkStealth.sqf";
	world_sunRise =				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_sunRise.sqf";
	world_surfaceNoise =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_surfaceNoise.sqf";
	player_humanityMorph =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_humanityMorph.sqf";
	player_throwObject = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_throwObject.sqf";
	player_alertZombies = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_alertZombies.sqf";
	player_fireMonitor = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\system\fire_monitor.sqf";
	fn_gearMenuChecks =			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_gearMenuChecks.sqf";
	
	
	object_roadFlare = 			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\object_roadFlare.sqf";
	object_setpitchbank	=		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_setpitchbank.sqf";
	object_monitorGear =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\object_monitorGear.sqf";
	
	
	zombie_findTargetAgent = 	compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\zombie_findTargetAgent.sqf";
	zombie_loiter = 			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\zombie_loiter.sqf";			
	zombie_generate = 			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\zombie_generate.sqf";			
	wild_spawnZombies = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\wild_spawnZombies.sqf";			
	
	pz_attack = 	compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\pzombie\pz_attack.sqf";
	
	player_build = compile preprocessFileLineNumbers "dayz_code\compiles\player_build.sqf";

	antiWall = compile preprocessFileLineNumbers "dayz_code\compiles\antiWall.sqf";				
	anti_discWall = compile preprocessFileLineNumbers "dayz_code\compiles\anti_discWall.sqf";	
	refresh_build_recipe_dialog = compile preprocessFileLineNumbers "buildRecipeBook\refresh_build_recipe_dialog.sqf"; 				
	refresh_build_recipe_list_dialog = compile preprocessFileLineNumbers "buildRecipeBook\refresh_build_recipe_list_dialog.sqf"; 	


	
	dog_findTargetAgent = 	compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\dog_findTargetAgent.sqf";
	
	
	vehicle_handleDamage    = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\vehicle_handleDamage.sqf";
	vehicle_handleKilled    = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\vehicle_handleKilled.sqf";

	
	player_countmagazines =	compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_countmagazines.sqf";
	player_addToolbelt =		compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_addToolbelt.sqf";
	player_copyKey =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_copyKey.sqf";
	player_reloadMag =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_reloadMags.sqf";
	player_loadCrate =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_loadCrate.sqf";
	player_craftItem =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_craftItem.sqf";
	player_tentPitch =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\tent_pitch.sqf";
	player_vaultPitch =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\vault_pitch.sqf";
	player_drink =				compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_drink.sqf";
	player_eat =				compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_eat.sqf";
	player_useMeds =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_useMeds.sqf";
	
if(bottlerainScript)then{
	player_fillWater = compile preprocessFileLineNumbers "scripts\player_waterfill.sqf";
}else{
	player_fillWater = 			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\water_fill.sqf";
};
	player_makeFire =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_makefire.sqf";
	player_chopWood =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_chopWood.sqf";
	player_harvestPlant =		compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_harvestPlant.sqf";
	player_goFishing =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_goFishing.sqf";
	
	player_wearClothes =		compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_wearClothes.sqf";
	player_dropWeapon =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_dropWeapon.sqf";
	player_setTrap =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_setTrap.sqf";
	object_pickup = 			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\object_pickup.sqf";
	player_flipvehicle = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_flipvehicle.sqf";
	player_sleep = 				compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_sleep.sqf";
	player_mineOre =			compile preprocessFileLineNumbers "\z\addons\dayz_code\actions\player_mineOre.sqf";
	
	
	player_selectSlot =			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\ui_selectSlot.sqf";
	player_gearSync	=			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_gearSync.sqf";
	player_gearSet	=			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_gearSet.sqf";
	ui_changeDisplay = 			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\ui_changeDisplay.sqf";
	ui_gear_sound =             compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\ui_gear_sound.sqf";
	
	
	player_monitor =			compile preprocessFileLineNumbers "\z\addons\dayz_code\system\player_monitor.sqf";
	player_spawn_1 =			compile preprocessFileLineNumbers "\z\addons\dayz_code\system\player_spawn_1.sqf";
	player_spawn_2 =			compile preprocessFileLineNumbers "Scripts\player_spawn_2.sqf";
	onPreloadStarted 			"dayz_preloadFinished = false;";
	onPreloadFinished 			"dayz_preloadFinished = true;";
	
	
	
	[] spawn {
		private["_timeOut","_display","_control1","_control2"];
		disableSerialization;
		_timeOut = 0;
		dayz_loadScreenMsg = "";
		diag_log "DEBUG: loadscreen guard started.";
		_display = uiNameSpace getVariable "BIS_loadingScreen";
		_control1 = _display displayctrl 8400;
		_control2 = _display displayctrl 102;
		
		while { _timeOut < 3000 && !dayz_clientPreload && !dayz_authed } do {

			if ( isNull _display ) then {
				waitUntil { !dialog; };
				startLoadingScreen ["","RscDisplayLoadCustom"];
				_display = uiNameSpace getVariable "BIS_loadingScreen";
				_control1 = _display displayctrl 8400;
				_control2 = _display displayctrl 102;
			};

			if ( dayz_loadScreenMsg != "" ) then {
				_control1 ctrlSetText dayz_loadScreenMsg;
				dayz_loadScreenMsg = "";
			};
			_control2 ctrlSetText format["%1",round(_timeOut*0.01)];
			_timeOut = _timeOut + 1;
			sleep 0.01;
		};
		endLoadingScreen;
	}; 

	
	RunTime = 0;
	TotalRuns = 0;
	
	fnc_dump = {
		private["_code","_benchmark","_averageRunTime"];
		_code = _this select 0;
		_benchmark = _this select 1;
		
		RunTime = RunTime + _benchmark;
		TotalRuns = TotalRuns + 1;
		_averageRunTime = RunTime/TotalRuns;

		diag_log format["%1 - %2 (%3 / %4)",_code,_benchmark,_averageRunTime,TotalRuns];
	};
	dayz_losChance = {
		private["_agent","_maxDis","_dis","_val","_maxExp","_myExp"];
		_agent = 	_this select 0;
		_dis =		_this select 1;
		_maxDis = 	_this select 2;
		
		_val = 		(_maxDis - _dis) max 0;
		_maxExp = 	((exp 2) * _maxDis);
		_myExp = 	((exp 2) * (_val)) / _maxExp;
		_myExp = _myExp * 0.7;
		_myExp
	};
	
	ui_initDisplay = {
		private["_control","_ctrlBleed","_display","_ctrlFracture","_ctrlDogFood","_ctrlDogWater","_ctrlDogWaterBorder", "_ctrlDogFoodBorder"];
		disableSerialization;
		_display = uiNamespace getVariable 'DAYZ_GUI_display';
		_control = 	_display displayCtrl 1204;
		_control ctrlShow false;
		if (!r_player_injured) then {
			_ctrlBleed = 	_display displayCtrl 1303;
			_ctrlBleed ctrlShow false;
		};
		if (!r_fracture_legs and !r_fracture_arms) then {
			_ctrlFracture = 	_display displayCtrl 1203;
			_ctrlFracture ctrlShow false;
		};
		_ctrlDogFoodBorder = _display displayCtrl 1501;
		_ctrlDogFoodBorder ctrlShow false;
		_ctrlDogFood = _display displayCtrl 1701;
		_ctrlDogFood ctrlShow false;
		
		_ctrlDogWaterBorder = _display displayCtrl 1502;
		_ctrlDogWaterBorder ctrlShow false;
		_ctrlDogWater = _display displayCtrl 1702;
		_ctrlDogWater ctrlShow false
	};
	
	dayz_losCheck = {
		private["_target","_agent","_cantSee"];
		_target = _this select 0; 
		_agent = _this select 1;
		_cantSee = true;
		if (!isNull _target) then {
			_tPos = aimPos _target;
			_zPos = aimPos _agent;
			if ((count _tPos > 0) and (count _zPos > 0)) then {
				_cantSee = terrainIntersectASL [_tPos, _zPos];
				if (!_cantSee) then {
					_cantSee = lineIntersects [_tPos, _zPos, _agent, vehicle _target];
				};
			};
		};
		_cantSee
	};
	
	eh_zombieInit = 	{
		private["_unit","_pos"];
		
		
		
	};
	
	dayz_equipCheck = {
		private ["_empty", "_needed","_diff","_success"];
		_config = _this;
		_empty = [player] call BIS_fnc_invSlotsEmpty;
		_needed = [_config] call BIS_fnc_invSlotType;
		_diff = [_empty,_needed] call BIS_fnc_vectorDiff;
		
		_success = true;
		{
			if (_x > 0) then {_success = false};
		} forEach _diff;
		hint format["Config: %5\nEmpty: %1\nNeeded: %2\nDiff: %3\nSuccess: %4",_empty,_needed,_diff,_success,_config];
		_success
	};

	vehicle_gear_count = {
		private["_counter"];
		_counter = 0;
		{
			_counter = _counter + _x;
		} forEach _this;
		_counter
	};
	
	dayz_spaceInterrupt = {
		private ["_dikCode", "_handled"];
		_dikCode = 	_this select 1;
		
		_handled = false;

		if (_dikCode in[0x58,0x57,0x44,0x43,0x42,0x41,0x40,0x3F,0x3E,0x3D,0x3C,0x3B,0x0B,0x0A,0x09,0x08,0x07,0x06,0x05]) then {
			_handled = true;
		};
	
		if (_dikCode in actionKeys "MoveForward") exitWith {r_interrupt = true};
		if (_dikCode in actionKeys "MoveLeft") exitWith {r_interrupt = true};
		if (_dikCode in actionKeys "MoveRight") exitWith {r_interrupt = true};
		if (_dikCode in actionKeys "MoveBack") exitWith {r_interrupt = true};

		
		if ((_dikCode in actionKeys "Prone") and r_drag_sqf) exitWith { force_dropBody = true; };
		if ((_dikCode in actionKeys "Crouch") and r_drag_sqf) exitWith { force_dropBody = true; };
		
		_shift = 	_this select 2;
		_ctrl = 	_this select 3;
		_alt =		_this select 4;

		

		
		if (_dikCode in (actionKeys "GetOver")) then {
			
			if (player isKindOf  "PZombie_VB") then {
				_handled = true;
				DZE_PZATTACK = true;
			} else {
				_nearbyObjects = nearestObjects[getPosATL player, dayz_disallowedVault, 8];
				if (count _nearbyObjects > 0) then {
					if((diag_tickTime - dayz_lastCheckBit > 4)) then {
						[objNull, player, rSwitchMove,"GetOver"] call RE;
						player playActionNow "GetOver";
						dayz_lastCheckBit = diag_tickTime;
					} else {
						_handled = true;
					};
				};
			};
		};
		
		
		if (_dikCode == 210) then {
				_nill = execvm "\z\addons\dayz_code\actions\playerstats.sqf";
		};
		
		if (_dikCode in actionKeys "ForceCommandingMode") then {_handled = true};
		if (_dikCode in actionKeys "PushToTalk" and (diag_tickTime - dayz_lastCheckBit > 10)) then {
			dayz_lastCheckBit = diag_tickTime;
			[player,50,true,(getPosATL player)] spawn player_alertZombies;
		};
		if (_dikCode in actionKeys "VoiceOverNet" and (diag_tickTime - dayz_lastCheckBit > 10)) then {
			dayz_lastCheckBit = diag_tickTime;
			[player,50,true,(getPosATL player)] spawn player_alertZombies;
		};
		if (_dikCode in actionKeys "PushToTalkDirect" and (diag_tickTime - dayz_lastCheckBit > 10)) then {
			dayz_lastCheckBit = diag_tickTime;
			[player,15,false,(getPosATL player)] spawn player_alertZombies;
		};
		if (_dikCode in actionKeys "Chat" and (diag_tickTime - dayz_lastCheckBit > 10)) then {
			dayz_lastCheckBit = diag_tickTime;
			[player,15,false,(getPosATL player)] spawn player_alertZombies;
		};
		if (_dikCode in actionKeys "User20" and (diag_tickTime - dayz_lastCheckBit > 5)) then {
			dayz_lastCheckBit = diag_tickTime;
			_nill = execvm "\z\addons\dayz_code\actions\playerstats.sqf";
		};
		
		
		if ((_dikCode == 0xC9 and (!_alt or !_ctrl)) or (_dikCode in actionKeys "User15")) then {
			DZE_Q = true;
		};
		
		if ((_dikCode == 0xD1 and (!_alt or !_ctrl)) or (_dikCode in actionKeys "User16")) then {
			DZE_Z = true;
		};


		
		if ((_dikCode == 0xC9 and (_alt and !_ctrl)) or (_dikCode in actionKeys "User13")) then {
			DZE_Q_alt = true;
		};
		
		if ((_dikCode == 0xD1 and (_alt and !_ctrl)) or (_dikCode in actionKeys "User14")) then {
			DZE_Z_alt = true;
		};


		
		if ((_dikCode == 0xC9 and (!_alt and _ctrl)) or (_dikCode in actionKeys "User7")) then {
			DZE_Q_ctrl = true;
		};
		
		if ((_dikCode == 0xD1 and (!_alt and _ctrl)) or (_dikCode in actionKeys "User8")) then {
			DZE_Z_ctrl = true;
		};




		
		if (_dikCode == 0x10 or (_dikCode in actionKeys "User17")) then {
			DZE_4 = true;
		};		
		
		if (_dikCode == 0x12 or (_dikCode in actionKeys "User18")) then {
			DZE_6 = true;
		};
		
		if (_dikCode == 0x39 or (_dikCode in actionKeys "User19")) then {
			DZE_5 = true;
		};

		
		if (_dikCode == 0x01) then {
			DZE_cancelBuilding = true;
		};
		
		if ((_dikCode == 0x3E or _dikCode == 0x0F or _dikCode == 0xD3) and (diag_tickTime - dayz_lastCheckBit > 10)) then {
			dayz_lastCheckBit = diag_tickTime;
			call dayz_forceSave;
		};
		_handled
	};
	
	player_setDate = {
		private ["_setdatebool"];
		_setdatebool = false;
		if (!([_this, date] call BIS_fnc_areEqual)) exitWith {
			_setdatebool = true;
		};
		if (_setdatebool) then {
			setDate _this;
		};
	};

	player_serverModelChange = {
		private["_object","_model"];
		_object = _this select 0;
		_model = _this select 1;
		if (_object == player) then {
			_model call player_switchModel;
		};
	};
	
	player_guiControlFlash = 	{
		private["_control"];
		_control = _this;
		if (ctrlShown _control) then {
			_control ctrlShow false;
		} else {
			_control ctrlShow true;
		};
	};
	
	gear_ui_offMenu = {
		private["_control","_parent","_menu"];
		disableSerialization;
		_control = 	_this select 0;
		_parent = 	findDisplay 106;
		if (!(_this select 3)) then {
			for "_i" from 0 to 9 do {
				_menu = _parent displayCtrl (1600 + _i);
				_menu ctrlShow false;
			};
			_grpPos = ctrlPosition _control;
			_grpPos set [3,0];
			_control ctrlSetPosition _grpPos;
			_control ctrlShow false;
			_control ctrlCommit 0;
		};
	};
	

	gear_ui_init = {
		private["_control","_parent","_menu","_dspl","_grpPos"];
		disableSerialization;
		_parent = findDisplay 106;
		_control = 	_parent displayCtrl 6902;
		for "_i" from 0 to 9 do {
			_menu = _parent displayCtrl (1600 + _i);
			_menu ctrlShow false;
		};
		_grpPos = ctrlPosition _control;
		_grpPos set [3,0];
		_control ctrlSetPosition _grpPos;
		_control ctrlShow false;
		_control ctrlCommit 0;
	};
	
	dayz_eyeDir = {
		private["_vval","_vdir"];
		_vval = (eyeDirection _this);
		_vdir = (_vval select 0) atan2 (_vval select 1);
		if (_vdir < 0) then {_vdir = 360 + _vdir};
		_vdir
	};

	DZE_getModelName = {
		_objInfo = toArray(str(_this));
		_lenInfo = count _objInfo - 1;
		_objName = [];
		_i = 0;
		
		{
			if (58 == _objInfo select _i) exitWith {};
			_i = _i + 1;
		} forEach _objInfo;
		_i = _i + 2; 
		for "_k" from _i to _lenInfo do {
			_objName = _objName + [_objInfo select _k];
		};
		_objName = toLower(toString(_objName));
		_objName
	};
	
	dayz_originalPlayer =		player;
	
	
	
	TraderDialogCatList = 12000;
	TraderDialogItemList = 12001;
	TraderDialogBuyPrice = 12002;
	TraderDialogSellPrice = 12003;

	TraderCurrentCatIndex = -1;
	TraderCatList = -1;
	TraderItemList = -1;

	TraderDialogLoadItemList = {
		private ["_index", "_trader_id", "_activatingPlayer"];
		TraderItemList = -1;
		_index = _this select 0;

		if (_index < 0 or TraderCurrentCatIndex == _index) exitWith {};
		TraderCurrentCatIndex = _index;

		_trader_id = TraderCatList select _index;
		_activatingPlayer = player;

		lbClear TraderDialogItemList;
		ctrlSetText [TraderDialogBuyPrice, ""];
		ctrlSetText [TraderDialogSellPrice, ""];

		lbAdd [TraderDialogItemList, "Loading items..."];

		PVDZE_plr_TradeMenuResult = call compile format["tcacheBuy_%1;",_trader_id];

		if(isNil "PVDZE_plr_TradeMenuResult") then {
			PVDZE_plr_TradeMenu = [_activatingPlayer,_trader_id];
			publicVariableServer  "PVDZE_plr_TradeMenu";
			waitUntil {!isNil "PVDZE_plr_TradeMenuResult"};
		};

		lbClear TraderDialogItemList;
		_item_list = [];
		{
			private ["_header", "_item", "_name", "_type", "_textPart", "_qty", "_buy", "_bqty", "_bname", "_btype", "_btextCurrency", "_sell", "_sqty", "_sname", "_stype", "_stextCurrency", "_order", "_order", "_afile", "_File", "_count", "_bag", "_bagclass", "_index", "_image"];
			_header = _x select 0; 
			_item = _x select 1;
			_name = _item select 0;
			_type = _item select 1;
			switch (true) do { 
				case (_type == 1): { 
					_type = "CfgMagazines";
				}; 
				case (_type == 2): { 
					_type = "CfgVehicles";
				}; 
				case (_type == 3): { 
					_type = "CfgWeapons";
				}; 
			}; 
			
			_textPart =	getText(configFile >> _type >> _name >> "displayName");

			
			_qty = _x select 2;

			
			_buy = _x select 3;	
			_bqty = _buy select 0;
			_bname = _buy select 1;
			_btype = _buy select 2;
			switch(true)do{ 
				case (_btype == 1): { 
					_btype = "CfgMagazines";
				}; 
				case (_btype == 2): { 
					_btype = "CfgVehicles";
				}; 
				case (_btype == 3): { 
					_btype = "CfgWeapons";
				}; 
			}; 

			
			_btextCurrency = getText(configFile >> _btype >> _bname >> "displayName");

			_sell = _x select 4;
			_sqty = _sell select 0;
			_sname = _sell select 1;
			_stype = _sell select 2;
			switch(true)do{ 
				case (_stype == 1): { 
					_stype = "CfgMagazines";
				}; 
				case (_stype == 2): { 
					_stype = "CfgVehicles";
				}; 
				case (_stype == 3): { 
					_stype = "CfgWeapons";
				}; 
			}; 
			
			_stextCurrency =	getText(configFile >> _stype >> _sname >> "displayName");

			
			_order = _x select 5;

			
			_afile = _x select 7;
			_File = "\z\addons\dayz_code\actions\" + _afile + ".sqf";
			
			_count = 0;
			if(_type == "CfgVehicles") then {
				if (_afile == "trade_backpacks") then {
					_bag = unitBackpack player;
					_bagclass = typeOf _bag;
					if(_name == _bagclass) then {
						_count = 1;
					};
				} else {
					_count = {(typeOf _x) == _name} count (nearestObjects [player, [_name], 20]);
				}
			};

			if(_type == "CfgMagazines") then {
				_count = {_x == _name} count magazines player;
			};

			if(_type == "CfgWeapons") then {
				_count = {_x == _name} count weapons player;
			};

			_index = lbAdd [TraderDialogItemList, format["%1 (%2)", _textPart, _name]];

			if (_count > 0) then {
				lbSetColor [TraderDialogItemList, _index, [0, 1, 0, 1]];
			};

			_image = getText(configFile >> _type >> _name >> "picture");
			lbSetPicture [TraderDialogItemList, _index, _image];

			_item_list set [count _item_list, [
				_name,
				_textPart,
				_bqty,
				_bname,
				_btextCurrency,
				_sqty,
				_sname,
				_stextCurrency,
				_header,
				_File
			]];
		} forEach PVDZE_plr_TradeMenuResult;
		TraderItemList = _item_list;
	};

	TraderDialogShowPrices = {
		private ["_index", "_item"];
		_index = _this select 0;
		if (_index < 0) exitWith {};
		while {count TraderItemList < 1} do { sleep 1; };
		_item = TraderItemList select _index;
		ctrlSetText [TraderDialogBuyPrice, format["%1 %2", _item select 2, _item select 4]];
		ctrlSetText [TraderDialogSellPrice, format["%1 %2", _item select 5, _item select 7]];
	};

	TraderDialogBuy = {
		private ["_index", "_item", "_data"];
		_index = _this select 0;
		if (_index < 0) exitWith {
			cutText ["Trading canceled." , "PLAIN DOWN"];
		};
		_item = TraderItemList select _index;
		_data = [_item select 0, _item select 3, 1, _item select 2, "buy", _item select 4, _item select 1, _item select 8];
		[0, player, '', _data] execVM (_item select 9);
		TraderItemList = -1;
	};

	TraderDialogSell = {
		private ["_index", "_item", "_data"];
		_index = _this select 0;
		if (_index < 0) exitWith {
			cutText ["Trading canceled." , "PLAIN DOWN"];
		};
		_item = TraderItemList select _index;
		_data = [_item select 6, _item select 0, _item select 5, 1, "sell", _item select 1, _item select 7, _item select 8];
		[0, player, '', _data] execVM (_item select 9);
		TraderItemList = -1;
	};
	EpochDeathBoardDialogList = 21000;
	EpochDeathBoardDialogSText = 21001;
	EpochDeathBoardDeaths = [];


	EpochDeathBoardLoad = {
		createdialog "EpochDeathBoardDialog";
		{
			lbAdd [EpochDeathBoardDialogList, (_x select 0)];
		} forEach PVDZE_plr_DeathBResult;
	};


	EpochDeathBoardClick = {
		disableSerialization;
		private ["_i", "_record", "_output", "_record_stxt", "_name", "_image", "_h", "_m", "_format"];
		_quotes = [
			"Death is God's way of telling you not to be such a wise guy.",
			"What happens if you get scared half to death, twice?",
			"Don't upset me.. I'm running out of places to hide the bodies.",
			"Don't run, you'll just die tired.",
			"Give me immortality or give me death.",
			"I can't live with death; he's always leaving the toilet seat up.",
			"Why won't you die?!?!",
			"Guns don't kill people; death kills people. It's a proven medical fact."
		];
		_i = _this select 0;
		if (_i < 0) exitWith {};
		_output = _this select 1;
		_record = PVDZE_plr_DeathBResult select _i;
		_record_stxt = call compile format["epoch_death_board_record_%1;",_i];
		if(isNil "_record_stxt") then {
			_record_stxt = format["<t size='1.6' align='left'>%1</t><br /><br />", (_record select 0)];

			_format = {
				private ["_codeCount", "_str"];
				_str = format["%1", _this];
				_codeCount = (count (toArray _str));
				if (_codeCount == 1) then {
					_str = format["0%1", _str];
				};
				_str;
			};
			_h = (_record select 4) select 0;
			_m = (_record select 4) select 1;
		
			_record_stxt = format["%1<t size='1' align='left'>Died at %2:%3</t><br /><br />", _record_stxt, (_h call _format), (_m call _format)];
		
			if ((_record select 1) != 'unknown') then {
				_record_stxt = format["%1<t size='1' align='left'>Was killed by %2</t><br /><br />", _record_stxt, (_record select 1)];
			};
		
			if ((_record select 2) != 'unknown') then {
				_name = getText(configFile >> "cfgWeapons" >> (_record select 2) >> "displayName");
				_image = getText(configFile >> "cfgWeapons" >> (_record select 2) >> "picture");
				_record_stxt = format["%1<t size='1' align='left'>With a %2<br /><img size='3' image='%3' /></t><br /><br />", _record_stxt, _name, _image];
			};
		
			if (format["%1", (_record select 3)] != 'unknown') then {
				_record_stxt = format["%1<t size='1' align='left'>At a distance of %2m</t><br /><br />", _record_stxt, (_record select 3)];
			};
			_record_stxt = format["%1<t font='Bitstream'>%2</t>", _record_stxt, (_quotes call BIS_fnc_selectRandom)];
			call compile format["epoch_death_board_record_%1 = ""%2"";" ,_i , _record_stxt];
		};
		_output ctrlSetStructuredText parseText _record_stxt;
	};

	
	
};

	progressLoadingScreen 0.8;
	

	BIS_fnc_selectRandom =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\BIS_fnc\fn_selectRandom.sqf";		
	BIS_fnc_vectorAdd =         compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\BIS_fnc\fn_vectorAdd.sqf";		
	fnc_buildWeightedArray = 	compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_buildWeightedArray.sqf";		
	fnc_usec_damageVehicle =	compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageHandlerVehicle.sqf";		
	zombie_initialize = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\init\zombie_init.sqf";
	
	object_setHitServer =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\object_setHitServer.sqf";	
	object_setFixServer =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\object_setFixServer.sqf";	
	object_getHit =				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\object_getHit.sqf";			
	object_setHit =				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\object_setHit.sqf";			
	object_processHit =			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\object_processHit.sqf";		
	object_delLocal =			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\object_delLocal.sqf";
	
	fnc_usec_damageHandler =	compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageHandler.sqf";		
	fnc_veh_ResetEH = compile preprocessFileLineNumbers "\z\addons\dayz_code\init\veh_ResetEH.sqf";			
	
	vehicle_handleDamage    = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\vehicle_handleDamage.sqf";
	vehicle_handleKilled    = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\vehicle_handleKilled.sqf";
	
	fnc_inString = 				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_inString.sqf";	
	fnc_isInsideBuilding = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_isInsideBuilding.sqf";	
	fnc_isInsideBuilding2 = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_isInsideBuilding2.sqf";	
	fnc_isInsideBuilding3 = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_isInsideBuilding3.sqf";	
	dayz_zombieSpeak = 			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\object_speak.sqf";			
	vehicle_getHitpoints =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\vehicle_getHitpoints.sqf";
	local_gutObject =			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\local_gutObject.sqf";		
	
	
	
	local_lockUnlock =			compile preprocessFileLineNumbers "Scripts\local_lockUnlock.sqf";
	local_gutObjectZ =			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\local_gutObjectZ.sqf";		
	local_zombieDamage = 		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageHandlerZ.sqf";		
	local_setFuel =				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\local_setFuel.sqf";			
	local_eventKill = 			compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\local_eventKill.sqf";		
	
	curTimeStr =				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_curTimeStr.sqf";
	player_medBandage =			compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\publicEH\medBandaged.sqf";
	player_medInject =			compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\publicEH\medInject.sqf";
	player_medEpi =				compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\publicEH\medEpi.sqf";
	player_medTransfuse =		compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\publicEH\medTransfuse.sqf";
	player_medMorphine =		compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\publicEH\medMorphine.sqf";
	player_breaklegs =			compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\publicEH\medBreakLegs.sqf";
	player_medPainkiller =		compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\publicEH\medPainkiller.sqf";
	world_isDay = 				{if ((daytime < (24 - dayz_sunRise)) and (daytime > dayz_sunRise)) then {true} else {false}};
	player_humanityChange =		compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_humanityChange.sqf";
	spawn_loot =				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\spawn_loot.sqf";
	spawn_loot_small =				compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\spawn_loot_small.sqf";
	
	
	player_sumMedical = {
		private["_character","_wounds","_legs","_arms","_medical"];
		_character = 	_this;
		_wounds =		[];
		if (_character getVariable["USEC_injured",false]) then {
			{
				if (_character getVariable[_x,false]) then {
					_wounds set [count _wounds,_x];
				};
			} forEach USEC_typeOfWounds;
		};
		_legs = _character getVariable ["hit_legs",0];
		_arms = _character getVariable ["hit_arms",0];
		_medical = [
			_character getVariable["USEC_isDead",false],
			_character getVariable["NORRN_unconscious", false],
			_character getVariable["USEC_infected",false],
			_character getVariable["USEC_injured",false],
			_character getVariable["USEC_inPain",false],
			_character getVariable["USEC_isCardiac",false],
			_character getVariable["USEC_lowBlood",false],
			_character getVariable["USEC_BloodQty",12000],
			_wounds,
			[_legs,_arms],
			_character getVariable["unconsciousTime",0],
			_character getVariable["messing",[0,0]]
		];
		_medical
	};
	
	
	
	if (isServer) then {
		call compile preprocessFileLineNumbers "\z\addons\dayz_server\init\server_functions.sqf";
	} else {
		eh_localCleanup = {};
	};
	
	
	
	execVM "\z\addons\dayz_code\external\DynamicWeatherEffects.sqf";
	initialized = true;
