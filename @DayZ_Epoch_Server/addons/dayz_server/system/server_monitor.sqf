private ["_result","_pos","_wsDone","_dir","_block","_isOK","_countr","_objWpnTypes","_objWpnQty","_dam","_selection","_totalvehicles","_object","_idKey","_type","_ownerID","_worldspace","_intentory","_hitPoints","_fuel","_damage","_date","_script","_key","_outcome","_vehLimit","_hiveResponse","_objectCount","_codeCount","_objectArray","_hour","_minute","_data","_status","_val","_traderid","_retrader","_traderData","_id","_lockable","_debugMarkerPosition","_vehicle_0"];
[]execVM "\z\addons\dayz_server\system\s_fps.sqf"; //server monitor FPS (writes each ~181s diag_fps+181s diag_fpsmin*)

dayz_versionNo = 		getText(configFile >> "CfgMods" >> "DayZ" >> "version");
dayz_hiveVersionNo = 	getNumber(configFile >> "CfgMods" >> "DayZ" >> "hiveVersion");
_script = getText(missionConfigFile >> "onPauseScript");

// ### [CPC] Indestructible Buildables Fix
_cpcimmune =[
"WoodFloor_DZ",
"WoodFloorHalf_DZ",
"WoodFloorQuarter_DZ",
"Land_DZE_LargeWoodDoorLocked",
"WoodLargeWallDoor_DZ",
"WoodLargeWallWin_DZ",
"WoodLargeWall_DZ",
"Land_DZE_WoodDoorLocked",
"WoodSmallWallDoor_DZ",
"WoodSmallWallWin_DZ",
"Land_DZE_GarageWoodDoor",
"Land_DZE_GarageWoodDoorLocked",
"WoodLadder_DZ",
"WoodStairsSans_DZ",
"WoodStairs_DZ",
"WoodSmallWall_DZ",
"WoodSmallWallThird_DZ",
"CinderWallHalf_DZ",
"CinderWall_DZ",
"CinderWallDoorway_DZ",
"Land_DZE_LargeWoodDoor",
"MetalFloor_DZ",
"CinderWallDoorSmallLocked_DZ",
"CinderWallSmallDoorway_DZ",
"CinderWallDoor_DZ",
"LightPole_DZ",
"Land_plot_rust_vrata",
"Land_plot_green_vrata", 
"Land_Misc_ConcPipeline_EP1",
"Land_Misc_deerstand",
"CanvasHut_DZ",
"Land_Ind_TankSmall",
"Land_Misc_Scaffolding",
"HeliHCivil",
"Land_vez",
"Land_stodola_open",
"Land_Barn_W_01",
"Land_Ind_BoardsPack1",
"Land_Ind_Timbers",
"RampConcrete",
"Hhedgehog_concrete",
"Land_CncBlock",
"Hedgehog_DZ",
"Fence_corrugated_plate",
"Fort_RazorWire",
"Fence_Ind_long",
"Fence_Ind",
"Land_CamoNetB_EAST_EP1",
"Land_CamoNet_EAST",
"Land_CamoNetVar_EAST",
"Land_CamoNetVar_NATO",
"Land_CamoNetB_NATO",
"Land_CamoNet_NATO",
"Land_CamoNetB_EAST",
"Land_tent_east",
"Land_CamoNetB_NATO_EP1",
"Land_HouseV_1I4",
"Land_hut_old02",
"Land_Ind_SawMillPen"
"Land_Ind_Garage01",
"Land_pumpa",
"ZavoraAnim",
"Land_CamoNetVar_EAST_EP1",
"Land_CamoNet_NATO_EP1",
"Land_CamoNetVar_NATO_EP1",
"Land_CamoNet_EAST_EP1",
"vehicleShelter_cdf",
"Land_fort_bagfence_round",
"Land_fort_bagfence_corner",
"Land_fort_bagfence_long",
"Land_BagFenceRound",
"Land_Misc_Cargo2E",
"Land_Misc_Cargo2B",
"Ins_WarfareBConstructionSite",
"Misc_Cargo1Bo_military",
"Misc_cargo_cont_small_EP1",
"Land_fort_rampart_EP1",
"Land_ConcreteRamp",
"Land_prebehlavka",
"Land_fortified_nest_big",
"Land_fortified_nest_small",
"WarfareBDepot",
"WarfareBCamp",
"Land_Fort_Watchtower_EP1",
"Land_Fort_Watchtower",
"Base_WarfareBBarrier10xTall",
"Land_HBarrier_largeBase_WarfareBBarrier10x"
];
// ### [CPC] Indestructible Buildables Fix

if ((count playableUnits == 0) and !isDedicated) then {
	isSinglePlayer = true;
};

waitUntil{initialized}; //means all the functions are now defined

diag_log "HIVE: Starting";

// ### BASE BUILDING 1.2 ### SERVER SIDE BUILD ARRAYS - START
call build_baseBuilding_arrays;
// ### BASE BUILDING 1.2 ### SERVER SIDE BUILD ARRAYS - END
waituntil{isNil "sm_done"}; // prevent server_monitor be called twice (bug during login of the first player)

//Set the Time
//Send request
_key = "CHILD:307:";
_result = _key call server_hiveReadWrite;
_outcome = _result select 0;
if(_outcome == "PASS") then {
	_date = _result select 1; 
		
	if(dayz_fullMoonNights) then {
		//date setup
		//_year = _date select 0;
		//_month = _date select 1;
		//_day = _date select 2;
		_hour = _date select 3;
		_minute = _date select 4;
		
		//Force full moon nights
		_date = [2013,8,3,_hour,_minute];
	};
		
	if(isDedicated) then {
		setDate _date;
		PVDZE_plr_SetDate = _date;
		publicVariable "PVDZE_plr_SetDate";
	};

	diag_log ("HIVE: Local Time set to " + str(_date));
};

	
// Custom Configs
if(isnil "MaxVehicleLimit") then {
	MaxVehicleLimit = 50;
};
if(isnil "MaxHeliCrashes") then {
	MaxHeliCrashes = 5;
};
if(isnil "MaxDynamicDebris") then {
	MaxDynamicDebris = 100;
};
if(isnil "MaxAmmoBoxes") then {
	MaxAmmoBoxes = 3;
};
if(isnil "MaxMineVeins") then {
	MaxMineVeins = 50;
};
// Custon Configs End

if (isServer and isNil "sm_done") then {

	serverVehicleCounter = [];
	_hiveResponse = [];

	for "_i" from 1 to 5 do {
		diag_log "HIVE: trying to get objects";
		_key = format["CHILD:302:%1:", dayZ_instance];
		_hiveResponse = _key call server_hiveReadWrite;  
		if ((((isnil "_hiveResponse") || {(typeName _hiveResponse != "ARRAY")}) || {((typeName (_hiveResponse select 1)) != "SCALAR")})) then {
			diag_log ("HIVE: connection problem... HiveExt response:"+str(_hiveResponse));
			_hiveResponse = ["",0];
		} 
		else {
			diag_log ("HIVE: found "+str(_hiveResponse select 1)+" objects" );
			_i = 99; // break
		};
	};

	_objectArray = [];
	if ((_hiveResponse select 0) == "ObjectStreamStart") then {
		_objectCount = _hiveResponse select 1;
		diag_log ("HIVE: Commence Object Streaming...");
		for "_i" from 1 to _objectCount do { 
			_hiveResponse = _key call server_hiveReadWrite;
			_objectArray set [_i - 1, _hiveResponse];
			//diag_log (format["HIVE dbg %1 %2", typeName _hiveResponse, _hiveResponse]);
		};
		diag_log ("HIVE: got " + str(count _objectArray) + " objects");
	};

	// # START OF STREAMING #
	_countr = 0;	
	_totalvehicles = 0;
	{
		//Parse Array
		_countr = _countr + 1;

		_idKey = 	_x select 1;
		_type =		_x select 2;
		_ownerID = 	_x select 3;

		_worldspace = _x select 4;
		_intentory=	_x select 5;
		_hitPoints=	_x select 6;
		_fuel =		_x select 7;
		_damage = 	_x select 8;

		_dir = 0;
		_pos = [0,0,0];
		_wsDone = false;
		if (count _worldspace >= 2) then
		{
			_dir = _worldspace select 0;
			if (count (_worldspace select 1) == 3) then {
				_pos = _worldspace select 1;
				_wsDone = true;
			}
		};			
		if (!_wsDone) then {
			if (count _worldspace >= 1) then { _dir = _worldspace select 0; };
			_pos = [getMarkerPos "center",0,4000,10,0,2000,0] call BIS_fnc_findSafePos;
			if (count _pos < 3) then { _pos = [_pos select 0,_pos select 1,0]; };
			diag_log ("MOVED OBJ: " + str(_idKey) + " of class " + _type + " to pos: " + str(_pos));
		};

		if (_damage < 1) then {
			//diag_log format["OBJ: %1 - %2", _idKey,_type];
			
			//Create it
			_object = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
			_object setVariable ["lastUpdate",time];
			_object setVariable ["ObjectID", _idKey, true];

			_lockable = 0;
			if(isNumber (configFile >> "CfgVehicles" >> _type >> "lockable")) then {
				_lockable = getNumber(configFile >> "CfgVehicles" >> _type >> "lockable");
			};

			// fix for leading zero issues on safe codes after restart
			if (_lockable == 4) then {
				_codeCount = (count (toArray _ownerID));
				if(_codeCount == 3) then {
					_ownerID = format["0%1", _ownerID];
				};
				if(_codeCount == 2) then {
					_ownerID = format["00%1", _ownerID];
				};
				if(_codeCount == 1) then {
					_ownerID = format["000%1", _ownerID];
				};
			};

			if (_lockable == 3) then {
				_codeCount = (count (toArray _ownerID));
				if(_codeCount == 2) then {
					_ownerID = format["0%1", _ownerID];
				};
				if(_codeCount == 1) then {
					_ownerID = format["00%1", _ownerID];
				};
			};

			_object setVariable ["CharacterID", _ownerID, true];
			
			clearWeaponCargoGlobal  _object;
			clearMagazineCargoGlobal  _object;
			// _object setVehicleAmmo DZE_vehicleAmmo;
			
			/*
			if ((typeOf _object) in dayz_allowedObjects) then {
				_object addMPEventHandler ["MPKilled",{_this call object_handleServerKilled;}];
				// Test disabling simulation server side on buildables only.
				_object enableSimulation false;
				// used for inplace upgrades and lock/unlock of safe
				_object setVariable ["OEMPos", _pos, true];
			};
			*/
			
			_object setdir _dir;
			_object setposATL _pos;
			_object setDamage _damage;
// ### [CPC] Indestructible Buildables Fix
if (typeOf(_object) in _cpcimmune) then {
_object addEventHandler ["HandleDamage", {false}];
_object enableSimulation false;
};
// ### [CPC] Indestructible Buildables Fix

// ##### BASE BUILDING 1.2 Server Side ##### - START
// This sets objects to appear properly once server restarts
		//if ((_object isKindOf "Static") && !(_object isKindOf "TentStorage")) then {
		if (typeOf(_object) in allbuildables_class) then {		
			_object setpos [(getposATL _object select 0),(getposATL _object select 1), 0];
		};
		//Set Variable
		if (_object isKindOf "Infostand_2_EP1" && !(_object isKindOf "Infostand_1_EP1")) then {
			_object setVariable ["ObjectUID", _worldspace call dayz_objectUID2, true];
			_object enableSimulation false;
		};


		// Set whether or not buildable is destructable
		if (typeOf(_object) in allbuildables_class) then {
			diag_log ("SERVER: in allbuildables_class:" + typeOf(_object) + " !");
			for "_i" from 0 to ((count allbuildables) - 1) do
			{
				_classname = (allbuildables select _i) select _i - _i + 1;
				_result = [_classname,typeOf(_object)] call BIS_fnc_areEqual;
				if (_result) exitWith {
					_requirements = (allbuildables select _i) select _i - _i + 2;
					_isDestructable = _requirements select 13;
					diag_log ("SERVER: " + typeOf(_object) + " _isDestructable = " + str(_isDestructable));
					if (!_isDestructable) then {
						diag_log("Spawned: " + typeOf(_object) + " Handle Damage False");
						_object addEventHandler ["HandleDamage", {false}];
					};
					if (typeOf(_object) == "Grave") then {
						_object setVariable ["isBomb", true];
					};
				};
			};
			//gateKeypad = _object addaction ["Defuse", "\z\addons\dayz_server\compile\enterCode.sqf"];
		};
// ##### BASE BUILDING 1.2 Server Side ##### - END

			if (count _intentory > 0) then {
				if (_type in DZE_LockedStorage) then {
					// Fill variables with loot
					_object setVariable ["WeaponCargo", (_intentory select 0), true];
					_object setVariable ["MagazineCargo", (_intentory select 1), true];
					_object setVariable ["BackpackCargo", (_intentory select 2), true];
				} else {

					//Add weapons
					_objWpnTypes = (_intentory select 0) select 0;
					_objWpnQty = (_intentory select 0) select 1;
					_countr = 0;					
					{
						if(_x in (DZE_REPLACE_WEAPONS select 0)) then {
							_x = (DZE_REPLACE_WEAPONS select 1) select ((DZE_REPLACE_WEAPONS select 0) find _x);
						};
						_isOK = 	isClass(configFile >> "CfgWeapons" >> _x);
						if (_isOK) then {
							_block = 	getNumber(configFile >> "CfgWeapons" >> _x >> "stopThis") == 1;
							if (!_block) then {
								_object addWeaponCargoGlobal [_x,(_objWpnQty select _countr)];
							};
						};
						_countr = _countr + 1;
					} forEach _objWpnTypes; 
				
					//Add Magazines
					_objWpnTypes = (_intentory select 1) select 0;
					_objWpnQty = (_intentory select 1) select 1;
					_countr = 0;
					{
						if (_x == "BoltSteel") then { _x = "WoodenArrow" }; // Convert BoltSteel to WoodenArrow
						if (_x == "ItemTent") then { _x = "ItemTentOld" };
						_isOK = 	isClass(configFile >> "CfgMagazines" >> _x);
						if (_isOK) then {
							_block = 	getNumber(configFile >> "CfgMagazines" >> _x >> "stopThis") == 1;
							if (!_block) then {
								_object addMagazineCargoGlobal [_x,(_objWpnQty select _countr)];
							};
						};
						_countr = _countr + 1;
					} forEach _objWpnTypes;

					//Add Backpacks
					_objWpnTypes = (_intentory select 2) select 0;
					_objWpnQty = (_intentory select 2) select 1;
					_countr = 0;
					{
						_isOK = 	isClass(configFile >> "CfgVehicles" >> _x);
						if (_isOK) then {
							_block = 	getNumber(configFile >> "CfgVehicles" >> _x >> "stopThis") == 1;
							if (!_block) then {
								_object addBackpackCargoGlobal [_x,(_objWpnQty select _countr)];
							};
						};
						_countr = _countr + 1;
					} forEach _objWpnTypes;
				};
			};	
			
			if (_object isKindOf "AllVehicles") then {
				{
					_selection = _x select 0;
					_dam = _x select 1;
					if (_selection in dayZ_explosiveParts and _dam > 0.8) then {_dam = 0.8};
					[_object,_selection,_dam] call object_setFixServer;
				} forEach _hitpoints;

				_object setFuel _fuel;

				if (!((typeOf _object) in dayz_allowedObjects)) then {
					
					//_object setvelocity [0,0,1];
					_object call fnc_veh_ResetEH;		
					
					if(_ownerID != "0" and !(_object isKindOf "Bicycle")) then {
						_object setvehiclelock "locked";
						_object setVariable ["R3F_LOG_disabled",true,true];
					};
					
					_totalvehicles = _totalvehicles + 1;

					// total each vehicle
					serverVehicleCounter set [count serverVehicleCounter,_type];
				};
			};

			//Monitor the object
			PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_object];
		};
	} forEach _objectArray;
	// # END OF STREAMING #

	// preload server traders menu data into cache
	{
		// get tids
		_traderData = call compile format["menu_%1;",_x];
		if(!isNil "_traderData") then {
			{
				_traderid = _x select 1;

				_retrader = [];

				_key = format["CHILD:399:%1:",_traderid];
				_data = "HiveEXT" callExtension _key;

				//diag_log "HIVE: Request sent";
		
				//Process result
				_result = call compile format ["%1",_data];
				_status = _result select 0;
		
				if (_status == "ObjectStreamStart") then {
					_val = _result select 1;
					//Stream Objects
					//diag_log ("HIVE: Commence Menu Streaming...");
					call compile format["ServerTcache_%1 = [];",_traderid];
					for "_i" from 1 to _val do {
						_data = "HiveEXT" callExtension _key;
						_result = call compile format ["%1",_data];
						call compile format["ServerTcache_%1 set [count ServerTcache_%1,%2]",_traderid,_result];
						_retrader set [count _retrader,_result];
					};
					//diag_log ("HIVE: Streamed " + str(_val) + " objects");
				};

			} forEach (_traderData select 0);
		};
	} forEach serverTraders;

	//  spawn_vehicles
	_vehLimit = MaxVehicleLimit - _totalvehicles;
	diag_log ("HIVE: Spawning # of Vehicles: " + str(_vehLimit));
	if(_vehLimit > 0) then {
		for "_x" from 1 to _vehLimit do {
			[] spawn spawn_vehicles;
		};
	};
	//  spawn_roadblocks
	diag_log ("HIVE: Spawning # of Debris: " + str(MaxDynamicDebris));
	for "_x" from 1 to MaxDynamicDebris do {
		[] spawn spawn_roadblocks;
	};
	//  spawn_ammosupply at server start 1% of roadblocks
	diag_log ("HIVE: Spawning # of Ammo Boxes: " + str(MaxAmmoBoxes));
	for "_x" from 1 to MaxAmmoBoxes do {
		[] spawn spawn_ammosupply;
	};
	// call spawning mining veins
	diag_log ("HIVE: Spawning # of Veins: " + str(MaxMineVeins));
	for "_x" from 1 to MaxMineVeins do {
		[] spawn spawn_mineveins;
	};

	if(isnil "dayz_MapArea") then {
		dayz_MapArea = 10000;
	};
	if(isnil "HeliCrashArea") then {
		HeliCrashArea = dayz_MapArea / 2;
	};
	if(isnil "OldHeliCrash") then {
		OldHeliCrash = false;
	};

	allowConnection = true;

	// [_guaranteedLoot, _randomizedLoot, _frequency, _variance, _spawnChance, _spawnMarker, _spawnRadius, _spawnFire, _fadeFire]
	if(OldHeliCrash) then {
		nul = [3, 4, (50 * 60), (15 * 60), 0.75, 'center', HeliCrashArea, true, false] spawn server_spawnCrashSite;
	};
	//Airraid
	nul = [] spawn server_airRaid;
	nul = [7, 5, 700, 0, 0.99, 'center', 4000, true, false, true, 5, 1]spawn server_spawnC130CrashSite;
	if (isDedicated) then {
		// Epoch Events
		_id = [] spawn server_spawnEvents;
		// server cleanup
		_id = [] execFSM "\z\addons\dayz_server\system\server_cleanup.fsm";

		// spawn debug box
		_debugMarkerPosition = getMarkerPos "respawn_west";
		_debugMarkerPosition = [(_debugMarkerPosition select 0),(_debugMarkerPosition select 1),1];
		_vehicle_0 = createVehicle ["DebugBox_DZ", _debugMarkerPosition, [], 0, "CAN_COLLIDE"];
		_vehicle_0 setPos _debugMarkerPosition;
		_vehicle_0 setVariable ["ObjectID","1",true];

		// max number of spawn markers
		if(isnil "spawnMarkerCount") then {
			spawnMarkerCount = 10;
		};
		
		actualSpawnMarkerCount = 0;

		// count valid spawn marker positions
		for "_i" from 0 to spawnMarkerCount do {
			if (!([(getMarkerPos format["spawn%1", _i]), [0,0,0]] call BIS_fnc_areEqual)) then {
				actualSpawnMarkerCount = actualSpawnMarkerCount + 1;
			} else {
				// exit since we did not find any further markers
				_i = spawnMarkerCount + 99;
			};
			
		};
		diag_log format["Total Number of spawn locations %1", actualSpawnMarkerCount];
	};

	sm_done = true;
	publicVariable "sm_done";
};
