
private ["_loadouttype","_vehiclecrews","_crew_units","_is_veh_group","_circledefend","_relTX","_relTY","_relUX","_relUY","_waiting","_pursue","_react","_newpos","_currPos","_orgPos","_targetPos","_attackPos","_flankPos","_avoidPos","_speedmode","_dist","_lastdist","_lastmove1","_lastmove2","_gothit","_supressed","_flankdist","_nBuilding","_nBuildingt","_distnbuid","_distnbuidt","_objsflankPos1","_cntobjs1","_objsflankPos2","_cntobjs2","_targettext","_dir1","_dir2","_dir3","_dd","_timeontarget","_dirf1","_dirf2","_fightmode","_flankPos2","_reinforcement","_reinforcementsent","_target","_targets","_flankdir","_prov","_lastpos","_newtarget","_planta","_nomove","_newflankAngle","_sharedist","_fldest","_grpidx","_grpid","_i","_unitpos","_Behaviour","_incar","_inheli","_inboat","_gunner","_driver","_vehicle","_minreact","_lastreact","_rnd","_GetOutDist","_GetOut","_GetIn_NearestVehicles","_makenewtarget","_index","_wp","_grp","_wptype","_wpformation","_targetdead","_frontPos","_GetIn","_dist1","_dist2","_dist3","_fldestfront","_fldest2","_bld","_flyInHeight","_fortify","_buildingdist","_rfid","_rfidcalled","_Mines","_enemytanks","_enemytanksnear","_friendlytanksnear","_mineposition","_enemytanknear","_roads","_timeout","_lastcurrpos","_wait","_countfriends","_side","_SURRENDER","_spawned","_nowp","_unitsIn","_ambush","_ambushed","_ambushdist","_friendside","_enemyside","_newattackPos","_fixedtargetpos","_NearestEnemy","_targetdist","_cargo","_targetsnear","_landing","_ambushwait","_membertypes","_respawn","_respawnmax","_lead","_safemode","_vehicles","_lastwptype","_template","_unittype","_initstr","_fortifyorig","_nowpType","_ambushtype","_vehicletypes","_onroad","_loop2","_tries2","_targetPosTemp","_sokilled","_sowounded","_nosmoke","_newunit","_rlastpos","_rcurrpos","_jumpers","_isSoldier","_noveh","_deadBodiesReact","_e","_npc","_exit","_sharedenemy","_friendlytanks","_closeenough","_initpos","_orgMode","_orgSpeed","_try","_posinfo","_bldpos","_track","_trackername","_markerobj","_markertype","_markercolor","_destname","_surrended","_lastknown","_opfknowval","_currcycle","_groupOne","_pause","_speed","_fm","_rstuckControl","_tries","_centerpos","_centerX","_centerY","_areasize","_rangeX","_rangeY","_areadir","_a","_dp","_drydist","_swimming","_loop","_cont","_currX","_currY","_npcname","_allow_respawn","_grouptype","_unit_weapon_names","_unit_items","_unit_tools","_grps_upd","_check","_valuearray","_grps_band","_grps_sold","_grps_surv","_foreachIndex","_UCthis","_group","_leader","_leader_weapon_names","_leader_items","_leader_tools","_cond","_leadername","_gridspawn","_obj","_grpname","_areamarker","_showmarker","_members","_isman","_iscar","_isboat","_isplane","_friends","_enemies","_area","_cosdir","_sindir","_mindist","_orgDir","_orgWatch","_maxmove","_moved","_damm","_dammchg","_lastdamm","_hitPos","_sin0","_sin90","_cos90","_sin270","_cos270","_fortify2","_nofollow","_shareinfo","_areatrigger","_cycle","_noslow","_deletedead","_respawntime","_type","_unit_skills","_leaderskills","_ai_type","_timeonwaypoint","_circle_up","_veh","_tmp_cargo_units","_tmp_count_units","_tmp_vehicle_number","_tmp_veh_units"];
if (!isServer) exitWith {};
if (isNil("KRON_UPS_INIT")) then {
KRON_UPS_INIT=0;
diag_log "needed to wait for UPSMON init";
};
waitUntil {KRON_UPS_INIT==1};
_UCthis = [];
for [{_i=0},{_i<count _this},{_i=_i+1}] do {_e=_this select _i; if (typeName _e=="STRING") then {_e=toUpper(_e)};_UCthis set [_i,_e]};
if ((count _this)<2) exitWith {
if (format["%1",_this]!="INIT") then {diag_log "UPS: Unit and marker name have to be defined!"};
};
_lastcurrpos=[0,0];
_grpid =0;
_exit = false;
_fldest = 0;
_unitpos = "AUTO";
_vehicle = objnull;
_minreact = KRON_UPS_minreact;
_lastreact = KRON_UPS_minreact;
_rnd = 0.0;
_GetOutDist = 0;
_GetOut=false;
_index = 0;
_wp=[];
_wptype="HOLD";
_wpformation = "VEE";
_targetdead = false;
_GetIn=false;
_dist3 = 0;
_fldestfront = 0;
_fldest2=0;
_bld = objnull;
_flyInHeight = 0;
_rfid = 0;
_rfidcalled = false;
_Mines = 5;
_enemytanks = [];
_friendlytanks =[];
_enemytanksnear = false;
_friendlytanksnear = false;
_mineposition = [0,0,0];
_enemytanknear = objnull;
_NearestEnemy = objnull;
_roads = [];
_timeout = 0;
_wait=90;
_countfriends = 0;
_side="";
_friendside=[];
_enemyside=[];
_SURRENDER = 0;
_surrended = false;
_inheli = false;
_spawned = false;
_nowp = false;
_unitsIn = [];
_ambush = false;
_ambushed = false;
_ambushdist = KRON_UPS_ambushdist;
_deadBodiesreact = R_deadBodiesReact; 
_dist2 = 0;
_targetdist = 10000;
_cargo = [];
_targetsnear = false;
_landing=false;
_ambushwait = 10000;
_membertypes = [];
_vehicletypes =[];
_crew_units = [];
_vehiclecrews=[];
_respawn = false;
_respawnmax = 10000;
_lead=objnull;
_safemode=["CARELESS","SAFE"];
_vehicles = [];
_dist3=0;
_lastwptype = "";
_unittype = "";
_initstr = "";
_fortifyorig= false;
_rlastPos = [0,0,0];
_obj = leader (_this select 0); 
_npc = _obj;
if ("SPAWNED" in _UCthis) then {
_grpid = parseNumber (_npc getVariable ["UPSMON_grpid","0"]);
if(_grpid==0) then{
KRON_UPS_Instances = KRON_UPS_Instances + 1;
_grpid = KRON_UPS_Instances;};
} else {
KRON_UPS_Instances = KRON_UPS_Instances + 1;
_grpid = KRON_UPS_Instances;};
_grpidx = format["%1",_grpid];
_grpname = format["%1_%2",(side _npc),_grpidx];
_side = side _npc;
_rnd = _grpid;{
_x allowDamage false;
[nil, _x, "per", rHideObject, true] call RE; 
_x disableAI "FSM";
} foreach units _npc;
sleep _rnd ;
_members = units _npc;
_npc = [_npc,_members] call MON_getleader;{
_x setVariable ["UPSMON_grpid", _grpid, false];
sleep 0.05;
if (side _x != civilian) then {
_x AddEventHandler ["hit", {nul = _this spawn R_SN_EHHIT}];
sleep 0.05;
_x AddEventHandler ["killed", {nul = _this spawn R_SN_EHKILLED}];
sleep 0.05;};
} foreach units _npc;
if (isnil {_npc getVariable ("UPSMON_grpid")}) then {
_npc setVariable ["UPSMON_grpid", _grpid, false];
sleep 0.05;
if (side _npc != civilian) then {
_npc AddEventHandler ["hit", {nul = _this spawn R_SN_EHHIT}];
sleep 0.05;
_npc AddEventHandler ["killed", {nul = _this spawn R_SN_EHKILLED}];
sleep 0.05;
}else{ 
_npc removeAllEventHandlers "firedNear";
sleep 0.05;
_npc AddEventHandler ["firedNear", {nul = _this spawn R_SN_EHFIREDNEAR}];
sleep 0.05;
_npc removeAllEventHandlers "killed";
sleep 0.05;
_npc AddEventHandler ["killed", {nul = _this spawn R_SN_EHKILLEDCIV}];
sleep 0.05;}};
R_GOTHIT_ARRAY = R_GOTHIT_ARRAY + [0];{
_x allowDamage true;
[nil, _x, "per", rHideObject, false] call RE;
_x enableAI "FSM";
} foreach units _npc;
if (KRON_UPS_Debug>0) then {diag_log format["Group %1: New instance UPSMON_grpid: %2",_grpidx,_npc getVariable ["UPSMON_grpid","not defined"]]}; 
_areamarker = _this select 1;
if (isNil ("_areamarker")) exitWith {
diag_log  "UPS: Area marker not defined.(Typo, or name not enclosed in quotation marks?)";};
_centerpos = getMarkerPos _areamarker;
_centerX = abs(_centerpos select 0);
_centerY = abs(_centerpos select 1);
_centerpos = [_centerX,_centerY];
_showmarker = if ("SHOWMARKER" in _UCthis) then {"SHOWMARKER"} else {"HIDEMARKER"};
if (_showmarker=="HIDEMARKER") then {
_areamarker setMarkerAlpha 0;};
_exit = true;
if (typename _npc=="OBJECT") then {
if (!isnull group _npc) then {
_npc = [_npc,units (group _npc)] call MON_getleader;
}else{
_vehicles = [_npc,2] call MON_nearestSoldiers;
if (count _vehicles>0) then {
_npc = [_vehicles select 0,units (_vehicles select 0)] call MON_getleader;};};
} else {
if (count _obj>0) then {
_npc = [_obj,count _obj] call MON_getleader;};};
if (!(_npc iskindof "Man")) then { 
if (!isnull(commander _npc) ) then {
_npc = commander _npc;
}else{
if (!isnull(driver _npc) ) then {
_npc = driver _npc;
}else{
_npc = gunner _npc;};};
group _npc selectLeader _npc;};
if (alive _npc) then {_exit = false;};
if (KRON_UPS_Debug>0 && _exit) then {diag_log format["KRON_UPS_DEBUG: Group %1 - There are no alive members in group %1 %2 %3",_grpidx, typename _npc, typeof _npc, count units _npc]};
if (_exit) exitWith {if (KRON_UPS_DEBUG>0) then {diag_log "KRON_UPS_DEBUG: Initialization aborted!"};};
_members = units _npc;
KRON_UPS_Total = KRON_UPS_Total + (count _members);
_vehicles = [];{
if (vehicle _x != _x ) then {
_vehicles = _vehicles - [vehicle _x];
_vehicles = _vehicles + [vehicle _x];
};
_membertypes = _membertypes + [typeof _x];
} foreach _members;{
_vehicletypes = _vehicletypes + [typeof _x];
} foreach _vehicles;{
_crew_units = [];{_crew_units set [count _crew_units, typeof _x];} foreach crew (vehicle _x);
_vehiclecrews set [count _vehiclecrews, _crew_units];
} foreach _vehicles;
_isman = "Man" countType [ vehicle _npc]>0;
_iscar = "LandVehicle" countType [vehicle _npc]>0;
_isboat = "Ship" countType [vehicle _npc]>0;
_isplane = "Air" countType [vehicle _npc]>0;
_isSoldier = _side != civilian;
_friends=[];
_enemies=[];
_sharedenemy=0;
if (_isSoldier) then {switch (_side) do {
case west:{ _sharedenemy=0; 
_friendside = [west];
_enemyside = [east];
};
case east:{  _sharedenemy=1; 
_friendside = [east];
_enemyside = [west];
};
case resistance:{ _sharedenemy=2; 
 _enemyside = KRON_UPS_Res_enemy;
if (!(east in _enemyside)) then {
_friendside = [east];
}; 
if (!(west in _enemyside)) then {
_friendside = [west];}; };};};
if (_side in KRON_UPS_Res_enemy) then {
_enemyside = _enemyside + [resistance];
}else {
_friendside = _friendside + [resistance];};
sleep .05;
_surrender = call (compile format ["KRON_UPS_%1_SURRENDER",_side]); {
if ( side _x in _friendside && ( _x iskindof "Tank"  || _x iskindof "Wheeled_APC" )) then {
_friendlytanks = _friendlytanks + [_x];};
}foreach vehicles;
_areasize = getMarkerSize _areamarker;
_rangeX = _areasize select 0;
_rangeY = _areasize select 1;
_area = abs((_rangeX * _rangeY) ^ 0.5);
_areadir = (markerDir _areamarker) * -1;
_cosdir=cos(_areadir);
_sindir=sin(_areadir);
_mindist=(_rangeX+_rangeY)/3;
if (_rangeX==0) exitWith {
diag_log format["UPSMON: Cannot patrol Sector: %1, Area Marker doesn't exist",_areamarker]; };
_orgMode = behaviour _npc;
_orgSpeed = speedmode _npc;
_currPos = getpos _npc;
_orgPos = _currPos;
_orgDir = getDir _npc;
_orgWatch=[_currPos,50,_orgDir] call KRON_relPos; 
_lastpos = _currPos;
_avoidPos = [0,0];
_flankPos = [0,0];
_attackPos = [0,0];
_newattackPos = [0,0];
_fixedtargetpos = [0,0];
_frontPos = [0,0];
_dirf1 = 0;_dirf2=0;_flankPos2=[0,0];
_dist = 10000;
_lastdist = 0;
_lastmove1 = 0;
_lastmove2 = 0;
_maxmove=0;
_moved=0;
_damm=0;
_dammchg=0;
_lastdamm = 0;
_timeontarget = 0;
_timeonwaypoint = 0;
_circle_up = false;
_respawntime = 0;
_fightmode = "walk";
_fm=0;
_gothit = false;
_pursue = false;
_hitPos=[0,0,0];
_react = 0;
_lastknown = 0;
_opfknowval = 0;
_sin0=1;
_sin90=1; _cos90=0;
_sin270=-1; _cos270=0;
_relTX=0;_relTY=0;
_relUX=0;_relUY=0;
_supressed = false;
_flankdist=0;
_nBuilding=nil;
_nBuildingt =nil;
_speedmode="Limited";
_distnbuid = 0;
_distnbuidt = 0;
_objsflankPos1 =  [];
_cntobjs1 = 0;
_objsflankPos2 =  [];
_cntobjs2 = 0;
_targettext ="";
_dir1 =0;_dir2=0;_dir3=0;_dd=0;
_reinforcement ="";
_reinforcementsent = false;
_target = objnull;
_newtarget=objnull;
_flankdir=0; 
_prov=0;
_targets=[];
_planta=0; 
_newflankAngle = 0;
_closeenough = KRON_UPS_closeenough;
_gunner = objnull;
_driver = objnull;
_fortify = false;
_buildingdist= 60;
_Behaviour = "SAFE"; 
_grp = grpnull;
_grp = group _npc;
_template = 0;
_nowpType = 1;
_ambushtype = 1;
_rstuckControl = 0;
_makenewtarget=true;
_npc setVariable ["SAR_fightmode",_fightmode,false];
if (_isplane) then {_closeenough = KRON_UPS_closeenough * 2};
_pause = if ("NOWAIT" in _UCthis) then {"NOWAIT"} else {"WAIT"};
_nomove  = if ("NOMOVE" in _UCthis) then {"NOMOVE"} else {"MOVE"};
_circledefend = if ("CIRCLEDEFEND" in _UCthis) then {true} else {false};
_fortify= if ("FORTIFY" in _UCthis) then {true} else {false};
_fortify2= if ("FORTIFY2" in _UCthis) then {true} else {false};
_fortifyorig = _fortify;
if (_fortify || _fortify2) then {
_nomove="NOMOVE";
_minreact = KRON_UPS_minreact * 3;
_buildingdist = _buildingdist * 2;
_makenewtarget = false;
_wait = 3000;};
if (_circledefend) then {
_nomove="NOMOVE";
_minreact = KRON_UPS_minreact * 3;
_buildingdist = _buildingdist / 2;
_makenewtarget = false;
_wait = 3000;};
_onroad = if ("ONROAD" in _UCthis) then {true} else {false};
_nosmoke = if ("NOSMOKE" in _UCthis) then {true} else {false};
_noveh = if ("NOVEH" in _UCthis) then {true} else {false};
_nowp = if ("NOWP" in _UCthis) then {true} else {false};
_nowp = if ("NOWP2" in _UCthis) then {true} else {_nowp};
_nowp = if ("NOWP3" in _UCthis) then {true} else {_nowp};
_nowpType = if ("NOWP2" in _UCthis) then {2} else {_nowpType};
_nowpType = if ("NOWP3" in _UCthis) then {3} else {_nowpType};
_ambush= if ("AMBUSH" in _UCthis) then {true} else {false};
_ambush= if ("AMBUSH:" in _UCthis) then {true} else {_ambush};
_ambush= if ("AMBUSH2" in _UCthis) then {true} else {_ambush};
_ambushwait = ["AMBUSH:",_ambushwait,_UCthis] call KRON_UPSgetArg;
_ambushwait = ["AMBUSH2:",_ambushwait,_UCthis] call KRON_UPSgetArg;
_ambushType = if ("AMBUSH2" in _UCthis) then {2} else {_ambushType};
_ambushType = if ("AMBUSH2:" in _UCthis) then {2} else {_ambushType};
_respawn = if ("RESPAWN" in _UCthis) then {true} else {false};
_respawn = if ("RESPAWN:" in _UCthis) then {true} else {_respawn};
_respawnmax = ["RESPAWN:",_respawnmax,_UCthis] call KRON_UPSgetArg;
_respawntime = ["RESPAWNTIME:",_respawntime,_UCthis] call KRON_UPSgetArg;
if (!_respawn) then {
_respawnmax = 0;
_respawntime = 0;};
_initstr = ["INIT:","",_UCthis] call KRON_UPSgetArg;
_nofollow = if ("NOFOLLOW" in _UCthis) then {"NOFOLLOW"} else {"FOLLOW"};
_shareinfo = if ("NOSHARE" in _UCthis) then {"NOSHARE"} else {"SHARE"};
_areatrigger = if ("TRIGGER" in _UCthis) then {"TRIGGER"} else {if ("NOTRIGGER" in _UCthis) then {"NOTRIGGER"} else {"SILENTTRIGGER"}};
if ("NOAI" in _UCthis) then {_isSoldier=false};
_cycle = ["CYCLE:",KRON_UPS_Cycle,_UCthis] call KRON_UPSgetArg;
_currcycle=_cycle;
if ("SPAWNED" in _UCthis) then {
_spawned= true;
} else {
_spawned= false;};
if (_spawned) then {if (KRON_UPS_Debug>0) then {diag_log format["KRON_UPS_DEBUG: Group %1 - squad has been spawned, respawns %2",_grpidx,_respawnmax]}; 
switch (side _npc) do {
case west:{ KRON_AllWest=KRON_AllWest + units _npc; };
case east:{  KRON_AllEast=KRON_AllEast + units _npc; };
case resistance:{  KRON_AllRes=KRON_AllRes + units _npc; 
if (east in KRON_UPS_Res_enemy ) then {
KRON_UPS_East_enemies = KRON_UPS_East_enemies+units _npc;
} else {
KRON_UPS_East_friends = KRON_UPS_East_friends+units _npc;
}; 
if (west in KRON_UPS_Res_enemy ) then {
KRON_UPS_West_enemies = KRON_UPS_West_enemies+units _npc;
} else {
KRON_UPS_West_friends = KRON_UPS_West_friends+units _npc;
};};};
call (compile format ["KRON_UPS_%1_Total = KRON_UPS_%1_Total + count (units _npc)",side _npc]); 
_vehicletypes = ["VEHTYPE:",_vehicletypes,_UCthis] call KRON_UPSgetArg;};
_initpos = "ORIGINAL";
if ("RANDOM" in _UCthis) then {_initpos = "RANDOM"};
if ("RANDOMUP" in _UCthis) then {_initpos = "RANDOMUP"}; 
if ("RANDOMDN" in _UCthis) then {_initpos = "RANDOMDN"}; 
if ((_initpos!="ORIGINAL") && ((!_isman) || (count _members)>1)) then {_initpos="RANDOMDN"};
_orgMode = "SAFE";
if ("CARELESS" in _UCthis) then {_orgMode = "CARELESS"}; 
if ("AWARE" in _UCthis) then {_orgMode = "AWARE"}; 
if ("COMBAT" in _UCthis) then {_orgMode = "COMBAT"}; 
if ("STEALTH" in _UCthis) then {_orgMode = "STEALTH"}; 
if (!_isSoldier) then {
_Behaviour = "SAFE";
} else {
_Behaviour = _orgMode; };
_npc setbehaviour _Behaviour;
_noslow = if ("NOSLOW" in _UCthis) then {"NOSLOW"} else {"SLOW"};
if (_noslow!="NOSLOW") then {
_orgSpeed = "limited";
} else {
_orgSpeed = "FULL";
}; 
_speedmode = _orgSpeed;
_npc setspeedmode _speedmode;
_template = ["TEMPLATE:",_template,_UCthis] call KRON_UPSgetArg;
if (_template > 0 && !_spawned) then {
KRON_UPS_TEMPLATES = KRON_UPS_TEMPLATES + ( [[_template]+[_side]+[_membertypes]+[_vehicletypes]] );
};
if (_initpos!="ORIGINAL") then {
_try=0;
_bld=0;
_bldpos=0;
while {_try<20} do {
_currPos=[_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
_posinfo=[_currPos] call KRON_PosInfo3;
_bld=_posinfo select 0;
_bldpos=_posinfo select 1;
if (_isplane || _isboat || !(surfaceiswater _currPos)) then {
if (((_initpos=="RANDOM") || (_initpos=="RANDOMUP")) && (_bldpos>0)) then {_try=99};
if (((_initpos=="RANDOM") || (_initpos=="RANDOMDN")) && (_bldpos==0)) then {_try=99};
};
_try=_try+1;
sleep .01;
};
if (_bldpos==0) then {
{ 
if (vehicle _x == _x) then {
_x setpos _currPos;
};
} foreach units _npc; 
sleep .5;
{ 
_targetpos = _currPos findEmptyPosition [10, 100];
sleep .4;
if (count _targetpos <= 0) then {_targetpos = _currpos};
_x setPos _targetpos;
} foreach _vehicles;
} else {
_npc setPos (_bld buildingPos _bldpos); 
_currPos = getPos _npc;
_nowp=true; 
};
};
if (_circledefend) then {
[_npc,"defend"] spawn SAR_circle_static;
};
_track = if (("TRACK" in _UCthis) || (KRON_UPS_Debug>0)) then {"TRACK"} else {"NOTRACK"};
_trackername = "";
_destname = "";
if (_track=="TRACK") then {
_track = "TRACK";
_trackername=format["trk_%1",_grpidx];
_markerobj = createMarker[_trackername,[0,0]];
_markerobj setMarkerShape "ICON";
_markertype = if (isClass(configFile >> "cfgMarkers" >> "WTF_Flag")) then {"WTF_FLAG"} else {"FLAG"};
_trackername setMarkerType _markertype;
_markercolor = switch (side _npc) do {
case west: {"ColorGreen"};
case east: {"ColorRed"};
case resistance: {"ColorBlue"};
default {"ColorBlack"};
};
_trackername setMarkerColor "ColorBlack";
_trackername setMarkerText format["%1",_grpidx];
_trackername setMarkerSize [.5,.5];
_trackername setmarkerpos _currPos; 
_destname=format["dest_%1",_grpidx];
_markerobj = createMarker[_destname,[0,0]];
_markerobj setMarkerShape "ICON";
_markertype = if (isClass(configFile >> "cfgMarkers" >> "WTF_Flag")) then {"WTF_FLAG"} else {"hd_objective"};
_destname setMarkerType _markertype;
_destname setMarkerColor _markercolor;
_destname setMarkerText format["%1",_grpidx];
_destname setMarkerSize [.5,.5];
};
_deletedead = ["DELETE:",0,_UCthis] call KRON_UPSgetArg;
if (_deletedead>0) then {
{
_x addEventHandler['killed',format["[_this select 0,%1] spawn KRON_deleteDead",_deletedead]];
sleep 0.01;
}forEach _members;
};
if ( _nomove=="NOMOVE" && !_circledefend ) then {
sleep 10;
 _unitsIn = [_grpid,_npc,150] call MON_GetIn_NearestStatic;
if ( count _unitsIn > 0 ) then { sleep 10};
[_npc, _buildingdist,false,_wait,true] spawn MON_moveNearestBuildings;
if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_Debug: Group %1: movetonearestbuilding",_grpid]};
};
_newpos = false;
_targetPos = [0,0,0];
_targettext ="_currPos";
_swimming = false;
_waiting = if (_nomove=="NOMOVE") then {9999} else {0};
_sharedist = if (_nomove=="NOMOVE") then {KRON_UPS_sharedist} else {KRON_UPS_sharedist*1.5};
if (format ["%1", _targetPos] == "[0,0,0]") then {
_index = (count waypoints _grp) - 1;
_wp = [_grp,_index];
_targetPos = waypointPosition _wp;
if (([_currpos,_targetPos] call KRON_distancePosSqr)<= 20) then {_targetPos = [0,0,0];};
};
_loop=true;
scopeName "main"; 
while {_loop} do {
if (KRON_UPS_Debug>0) then {diag_log format["KRON_UPS_DEBUG: Group: %1: _cycle=%2 _currcycle=%3 _react=%4 _waiting=%5, _timeonwaypoint=%6",_grpidx,_cycle,_currcycle,_react,_waiting,_timeonwaypoint]}; 
_timeontarget=_timeontarget+_currcycle;
_react=_react+_currcycle;
_waiting = _waiting - _currcycle;
_lastreact = _lastreact + _currcycle;
_newpos = false;
_sokilled = false;
_sowounded = false;
if ((R_GOTHIT_ARRAY select _grpId) != 0) then{
_gothit = true;
if ((R_GOTHIT_ARRAY select _grpId) == 1) then{
_sowounded = true;
}else {
_sokilled = true;
};
sleep 0.01;
R_GOTHIT_ARRAY set [_grpId, 0];
};
if (count _members==0) then {
_exit=true;
} else {
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
};
if (_exit) exitwith {};
{
_x allowDamage true;
[nil, _x, "per", rHideObject, false] call RE;
_x enableAI "FSM";
} foreach units _npc;
KRON_NPCs set [_grpid,_npc];
_currPos = getposASL _npc; 
_currX = _currPos select 0; 
_currY = _currPos select 1;
if (_track=="TRACK" || KRON_UPS_Debug>0) then { _trackername setmarkerpos _currPos; };
if ( _isSoldier && !_exit) then {
_pursue=false;
_incar = "LandVehicle" countType [vehicle (_npc)]>0;
_inheli = "Air" countType [vehicle (_npc)]>0;
_inboat = "Ship" countType [vehicle (_npc)]>0;
_targets = call (compile format ["KRON_targets%1",_sharedenemy]);
 if (KRON_UPS_AI_Debug>0 ) then {diag_log format["KRON_UPS_AI_Debug: targets via radio from global upsmon: %1",_targets]};
{
_NearestEnemy = _x findnearestenemy _x;
if (KRON_UPS_AI_Debug>0 && {!(isnull _NearestEnemy)}) then {diag_log format["KRON_UPS_AI_Debug: Nearest Enemy for %3 is %1, knows about value is %2",_NearestEnemy,_x knowsabout _NearestEnemy,_x]}; 
if (_x knowsabout _NearestEnemy > R_knowsAboutEnemy && {(_npc knowsabout _NearestEnemy <= R_knowsAboutEnemy || count _targets <= 0 )}) then {
if (_npc knowsabout _NearestEnemy <= R_knowsAboutEnemy ) then { 
_npc reveal _NearestEnemy;
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1 - %2 reveals target %3 to leader",_grpidx,typeof _x, typeof _NearestEnemy]}; 
};
if (count _targets <= 0) then {
_target = _NearestEnemy;
_targets set [count _targets,_NearestEnemy];
_NearestEnemy setvariable ["UPSMON_lastknownpos", position _NearestEnemy, false];
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1 - %2 added to targets",_grpidx,_target]}; 
};
};
} foreach units _npc;
if (isNull (_target)) then {
{
if ((_npc knowsabout _x > R_knowsAboutEnemy) && (alive _x) && (canmove _x)) then {
_target =_x;
if (!isNull (_target)) exitWith{};
};
} foreach _targets;
};
_dist = 10000;
if ( !isNull (_target) && alive _target ) then {
_newattackPos = _target getvariable ("UPSMON_lastknownpos");
if ( !isnil "_newattackPos" ) then {
_attackPos=_newattackPos;
_dist = ([_currpos,_attackPos] call KRON_distancePosSqr);
};
};
if (isNull (_target) || {!alive _target} || {!canmove _target} ) then {
_lastknown = 0;
_opfknowval = 0; 
_target = objnull; 
};
_newtarget = _target;
if ((_shareinfo=="SHARE")) then {
if ((KRON_UPS_comradio == 2)) then
{
_targetsnear = false;
if (!alive _target || {!canmove _target} || {_dist > _closeenough}) then {
{
 if ( !isnull _x && {canmove _x} && {alive _x} ) then {
_newattackPos = _x getvariable ("UPSMON_lastknownpos");
if (  !isnil "_newattackPos" ) then {
_dist3 = ([_currpos,_newattackPos] call KRON_distancePosSqr);
IF ( _dist3 <= (_closeenough + KRON_UPS_safedist)) then { _targetsnear = true };
if ( ( isnull (_newtarget) || captive _newtarget || !alive _newtarget || !canmove _newtarget || _dist3 < _dist ) 
&& {( _dist3 <= _sharedist || _reinforcementsent )}
&& {( !(_x iskindof "Air") || (_x iskindof "Air" && _isplane ))}
&& {( !(_x iskindof "Ship") || (_x iskindof "Ship" && _isboat ))}
&& {( _x emptyPositions "Gunner" == 0 && _x emptyPositions "Driver" == 0 
|| (!isnull (gunner _x) && canmove (gunner _x))
|| (!isnull (driver _x) && canmove (driver _x)))} 
) then {
_newtarget = _x;
_opfknowval = _npc knowsabout _x; 
_dist = _dist3;
if (_dist < _closeenough) exitWith {};
};
};
};
} foreach _targets;
sleep 0.5;
};
};
if ( !isNull (_newtarget) && {alive _newtarget} && {canmove _newtarget} && {(_newtarget != _target || isNull (_target))} ) then {
_timeontarget = 0;
_targetdead = false;
_flankdir= if (random 100 <= 10) then {0} else {_flankdir};
_target = _newtarget;
};
};
if !_nosmoke then {
{
if (_sowounded && {random 100 < R_USE_SMOKE_wounded}) then {
nul = [_x,_target] spawn MON_throw_grenade;
};
if (_sokilled && {random 100 < R_USE_SMOKE_killed}) then {
nul = [_x,_target] spawn MON_throw_grenade;
};
sleep 0.1;
} foreach _members;
};
if ( !isNull (_target) && {alive _target} ) then {
if (_fightmode != "fight" ) then {
_fightmode = "fight";
_npc setVariable ["SAR_fightmode",_fightmode,false];
_npc setCombatMode "RED";  
_react = KRON_UPS_react;
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1 - Enemy detected %2",_grpidx, typeof _target]}; 
if (_nowpType == 1) then {
nul = [_npc] call R_FN_deleteObsoleteWaypoints;
_nowp = false;
};
};
_newattackPos = _target getvariable ("UPSMON_lastknownpos");
if ( !isnil "_newattackPos" ) then {
_attackPos=_newattackPos;
_dist = ([_currpos,_attackPos] call KRON_distancePosSqr);
_members lookat _attackPos; 
};
};
if ( _fightmode != "walk" && {!isnull(_target)} && {_dist < KRON_UPS_sharedist} &&  {_npc knowsabout _target < R_knowsAboutEnemy} ) then {
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1 - Target lost",_grpidx]}; 
_fightmode="walk";
_npc setVariable ["SAR_fightmode",_fightmode,false];
_speedmode = _orgSpeed;
_target = objnull;
_Behaviour = _orgMode;
_waiting = -1;
_unitpos = "AUTO";
_pursue=false;
_targetdead= true;
_makenewtarget = true; 
};
if (_opfknowval>_lastknown ) then {
_react = _react + 20;
};
if (!_ambushed && {(_fightmode != "walk")} && {((_react >= KRON_UPS_react && _lastreact >=_minreact) || moveToCompleted _npc )}) then {
_pursue=true;
};
if (_ambush && !_ambushed) then {
_ambushed = true;
_nowp = true;
_currcycle = 2;
_grp setFormation "LINE";
_npc setBehaviour "STEALTH";
_npc setSpeedMode "FULL";
if ( _ambushType == 1 ) then {
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1: Putting down a mine for ambush",_grpidx]}; 
_npc setBehaviour "careless";
_dir1 = getDir _npc;
_mineposition = [position _npc,_dir1, (KRON_UPS_ambushdist / 1.2)] call MON_GetPos2D; 
_roads = _mineposition nearroads 50;
while {_Mines > 0} do
{
_i = 0;
if (count _roads > 0) then {
_rnd = floor (random (count _roads));
_mineposition = position (_roads select _rnd);
_roads = _roads - [_roads select _rnd];
if ([_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1; _i = 1;};
} else {
_mineposition = [position _npc,(_dir1-30) mod 360, (KRON_UPS_ambushdist / 1.2 ) + random 10] call MON_GetPos2D;
if ([_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1; _i = 1;};
};
sleep 0.1;
if (_i != 1) then {_Mines = _Mines -1;} 
};
_npc setBehaviour "careless";
sleep 30;
{
if (!stopped _x) then {
_x domove position _npc;
waituntil {moveToCompleted _x || moveToFailed _x || !alive _x || !canmove _x || _x distance _npc <= 5};
};
} foreach units _npc;
};
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
_grp setFormation "LINE";
_npc setBehaviour "AWARE";
sleep 10;
sleep 0.1;
_unitpos ="DOWN";
{
[_x,_unitpos] spawn MON_setUnitPos;
sleep 0.5;
_x stop true;
_x doWatch _mineposition;
} foreach units _npc;
_npc setBehaviour "STEALTH";
_pursue = false;
};
if (_ambush) then {
_prov = ((_ambushdist*2 - (_npc distance _NearestEnemy))*3) - 40;
 
if (_gothit  || _reinforcementsent || time > _ambushwait
|| ( "Air" countType [_NearestEnemy]<=0 
&& (_npc distance _NearestEnemy <= _ambushdist + random 10 
|| (!isNull (_NearestEnemy) && (( random 100 <= _prov &&  _npc distance _NearestEnemy > _lastdist)
|| _npc distance _NearestEnemy > _ambushdist*3 && _lastdist < _ambushdist*3 && _lastdist > 0))
))
) then {
sleep ((random 1) + 1); 
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1 - ATTACK !",_grpidx]};
_nowp = false;
_ambush = false;
_ambushed = false;
_currcycle = _cycle;
{
_x stop false;
_x setUnitPos "Auto";
} foreach _members;
_npc setBehaviour "STEALTH";
_npc setCombatMode "RED";
_pursue = false;
};
_lastdist = _npc distance _NearestEnemy;
}; 
if (alive _npc && !_nowp) then {
if (!_isman || {(vehicle (_npc) != _npc && !_inboat && !(vehicle (_npc) iskindof "StaticWeapon"))}) then { 
_unitsin = [];
if (!_inheli) then { 
if (_fightmode == "walk") then {
_GetOutDist =  _area / 20;
}else{
_GetOutDist =  _closeenough  * ((random .4) + 0.6);
};
if (_gothit || _dist <= _closeenough * 1.5 || {(_lastcurrpos select 0 == _currpos select 0 && _lastcurrpos select 1 == _currpos select 1 && moveToFailed (vehicle (_npc)))} || {moveTocompleted (vehicle (_npc))}) then 
{
_GetOutDist = 10000;
};
_unitsin = [_npc] call R_FN_allUnitsInCargo; 
private ["_handle1"];
_handle1 = [_npc,_targetpos,_GetOutDist] spawn R_SN_GetOutDist;
_timeout = time + 120;
waitUntil {scriptDone _handle1 || time > _timeout};
} else {
_GetOutDist = 0; 
};
if (count _unitsin > 0) then {
_timeout = time + 7;
{ 
waituntil {vehicle _x == _x || !canmove _x || !alive _x || time > _timeout || movetofailed _x  }; 
} foreach _unitsin;
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
if (_fightmode == "fight" || _gothit) then {
_npc setBehaviour "COMBAT";
_groupOne = group _npc;
_groupOne setFormation "DIAMOND";
nul = [_npc,30] spawn MON_move;
};
sleep 0.2;
{
if (alive _x && canmove _x) exitwith {group _x selectLeader _x; _npc = _x};
} foreach _unitsin;
if (_fightmode == "fight") then {
_pursue = true;
}else
{
_pursue = false;
_makenewtarget=true;
};
};
};
};
if (_gothit) then {
if (!_supressed) then {
_react = _react + 30;
};
if (_fightmode != "walk") then {
if (_nowpType != 3) then {
nul = [_npc] call R_FN_deleteObsoleteWaypoints;
_nowp = false; 
};
};
};
if (isNull (_target) || {!alive _target} ) then {
_pursue=false;
if (_gothit && {!_fortify} && {!_fortify2} && {!_circledefend} && {!_nowp}) then { 
if ((_fightmode == "walk")) then 
{
_Behaviour =  "COMBAT";
_speedmode = "FULL";
_unitpos = "AUTO";
_gothit = false;
_makenewtarget = true;
_waiting = -1;
if ((random 100 < 20) && !_nosmoke) then {
nul= [_npc,_target] spawn MON_throw_grenade;
};
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1 - Have been damaged moving",_grpidx,_makenewtarget]}; 
} else {
if ( _sowounded || {(_react >= KRON_UPS_react && _lastreact >=_minreact && count _targets <= 0)}) then {
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1 - Under fire by unkown target, moving to newpos",_grpidx]}; 
if (!_supressed && (random 100 < 80) && !_nosmoke) then {
nul= [_npc,_target] spawn MON_throw_grenade;
};
_gothit = false; 
_makenewtarget = true;
_waiting = -1;
_pause="NOWAIT";
_speedmode = "FULL";
_unitpos = "middle";
_Behaviour = "AWARE";
} else {
if (_lastreact >=_minreact && {!_targetdead}) then 
{
_targetdead = true;
_pursue = true;
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1 - Target defeated, searching",_grpidx]}; 
};
};
};
};
};
if (format ["%1",_fixedtargetPos] != "[0,0]") then {
if (([_currpos,_fixedtargetpos] call KRON_distancePosSqr) <= _closeenough || (_dist <= _closeenough && _gothit)) then {
_fixedtargetPos = [0,0]; 
} else {
_pursue = false;
_attackPos=_fixedtargetPos;
if (_react >= KRON_UPS_react && _lastreact >=_minreact) then {
_makenewtarget = true;
_unitpos = "AUTO"; 
_speed = "FULL";
};
};
};
if ( isnil "_attackPos") then {_pursue = false;};
if ( captive _target || format ["%1", _attackPos] == "[0,0]") then {_pursue = false;};
if (_nowp) then {
_makenewtarget = false;
_pursue = false;
};
if (_inheli) then {
_landing = vehicle (_npc) getVariable "UPSMON_landing";
if (isnil ("_landing")) then {_landing=false;};
if (_landing) then {
_pursue = false;
};
};
sleep 0.5;
if (_pursue) then {
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug:  Group %1: is in pursuit",_grpidx]}; 
_pursue = false;
_newpos = true; 
_react = 0;
_lastreact = 0;
_timeontarget = 0; 
_makenewtarget = false;
_fm = 1;
_supressed = false;
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || {!canmove _npc} || {isplayer _npc} ) exitwith {_exit=true;};
_targetPos = _attackPos;
_currPos = getpos _npc;
 
_pause="NOWAIT";
_waiting=0;
_dir1 = [_currPos,_targetPos] call KRON_getDirPos;
_dir2 = (_dir1+180) mod 360;
_flankdist = ((random 0.5)+0.7)*KRON_UPS_safedist;
_flankdist = if ((_flankdist*1.40) >= _dist) then {_dist*.65} else {_flankdist};
if (_inheli) then {_flankdist = _flankdist / 2;};
_avoidPos = [_currPos,_dir2, KRON_UPS_safedist] call MON_GetPos2D;
_frontPos = [_targetPos,_dir2, _flankdist] call MON_GetPos2D;
_newflankAngle = ((random(KRON_UPS_flankAngle)+1) * 2 * (_flankdist / KRON_UPS_safedist )) + (KRON_UPS_flankAngle/1.4) ;
if (_newflankAngle > KRON_UPS_flankAngle) then {_newflankAngle = KRON_UPS_flankAngle};
_dirf1 = (_dir2+_newflankAngle) mod 360;
_flankPos = [_targetPos,_dirf1, _flankdist] call MON_GetPos2D;
_dirf2 = (_dir2-_newflankAngle+360) mod 360;
_flankPos2 = [_targetPos,_dirf2, _flankdist] call MON_GetPos2D;
if (KRON_UPS_Debug>0) then {
"flank1" setmarkerpos _flankPos; 
"flank2" setmarkerpos _flankPos2; 
"target" setmarkerpos _attackPos;
};
_fldest = 0;
_fldest2 = 0;
_fldestfront = 0;
_i = 0;
{
if (_foreachindex !=0 && {_i != _grpid} &&  {format ["%1", _x] != "[0,0]"}) then {
_dist1 = [_x,_flankPos] call KRON_distancePosSqr;
_dist2 = [_x,_flankPos2] call KRON_distancePosSqr;
_dist3 = [_x,_frontPos] call KRON_distancePosSqr;
if (_dist1 <= _flankdist/1.5 || _dist2 <= _flankdist/1.5 || _dist3 <= _flankdist/1.5) then {
if (_dist1 < _dist2 && _dist1 < _dist3) then {_fldest = _fldest + 1;};
if (_dist2 < _dist1 && _dist2 < _dist3) then {_fldest2 = _fldest2 + 1;};
if (_dist3 < _dist1 && _dist3 < _dist2) then {_fldestfront = _fldestfront + 1;};
};
};
_i = _i + 1;
sleep 0.01;
} foreach KRON_targetsPos;
_i = 0;
{
if (_foreachindex > 0 && {_i != _grpid} && {!(isnull _x)})  then {
_dist1 = [getpos(_x),_flankPos] call KRON_distancePosSqr;
_dist2 = [getpos(_x),_flankPos2] call KRON_distancePosSqr;
_dist3 = [getpos(_x),_frontPos] call KRON_distancePosSqr;
if (_dist1 <= _flankdist/1.5 || _dist2 <= _flankdist/1.5 || _dist3 <= _flankdist/1.5) then {
if (_dist1 < _dist2 && _dist1 < _dist3) then {_fldest = _fldest + 1;};
if (_dist2 < _dist1 && _dist2 < _dist3) then {_fldest2 = _fldest2 + 1;};
if (_dist3 < _dist1 && _dist3 < _dist2) then {_fldestfront = _fldestfront + 1;};
};
};
_i = _i + 1;
sleep 0.01;
} foreach KRON_NPCs;
switch (_flankdir) do {
case 1: 
{_prov = 125};
case 2: 
{_prov = -25};
default
{_prov = 50};
};
if (_fldest<_fldest2) then {_prov = _prov + 50;};
if (_fldest2<_fldest) then {_prov = _prov - 50;};
if (_prov<0) then {_prov = 0;};
if ((random 100) <= _prov) then {
_flankdir =1;
_flankPos = _flankPos; _targettext = "_flankPos";
} else {
_flankdir =2;
_flankPos = _flankPos2; _targettext = "_flankPos2";
};
_targetPos = _flankPos;
_targettext = "_flankPos";
if ((surfaceIsWater _flankPos && !(_isplane || _isboat)) ) then {
_targetPos = _attackPos;_targettext ="_attackPos"; 
_flankdir =0;
} else {
if (_fldestfront < _fldest  && _fldestfront < _fldest2) then {
_targetPos = _frontPos;_targettext ="_frontPos"; 
};
};
_wptype = "MOVE";
_rnd = random 100;
if (_dist <= _closeenough) then {
if ( _dist <= _closeenough/2 ) then {
_speedmode = "LIMITED";
_wpformation = "LINE";
_unitpos = "AUTO"; 
_react = _react + KRON_UPS_react / 2;
_minreact = KRON_UPS_minreact / 2;
if ((_nomove == "NOMOVE" && _rnd < 25) && !_reinforcementsent) then {
_Behaviour =  "STEALTH"; 
_wptype = "HOLD";
} else {
if (_rnd < 80) then {
_Behaviour =  "COMBAT"; 
} else {
_Behaviour =  "AWARE";
};
_wptype = "MOVE";
_npc setCombatMode "RED";
}
} else {
_speedmode = "NORMAL";  
_wpformation = "VEE"; 
_unitpos = "AUTO";
_minreact = KRON_UPS_minreact / 1.5;
if ((_nomove == "NOMOVE" && _rnd < 50) && !_reinforcementsent) then {
_Behaviour =  "COMBAT"; 
_wptype = "HOLD";
} else {
if (_rnd < 70) then {
_Behaviour =  "AWARE";
} else {
_Behaviour =  "COMBAT";
};
_wptype = "MOVE";
_npc setCombatMode "YELLOW";
};
};
} else{
if (( _dist <= (_closeenough + KRON_UPS_safedist))) then {
_speedmode = "FULL";
_wpformation = "WEDGE";
_unitpos = if (_rnd < 90) then {"Middle"} else {"AUTO"};
_minreact = KRON_UPS_minreact;
if ((_nomove=="NOMOVE" && _rnd < 75)  && !_reinforcementsent) then {
_Behaviour =  "COMBAT"; 
_wptype = "HOLD";
} else {
_Behaviour =  "AWARE"; 
_wptype = "MOVE";
};
} else {
if (( _dist <  KRON_UPS_sharedist )) then {
_Behaviour =  "AWARE"; 
_speedmode = "FULL";
_unitpos = if (_rnd < 60) then {"Middle"} else {"AUTO"};
_minreact = KRON_UPS_minreact * 2;
if ((_nomove=="NOMOVE" && _rnd < 95) && !_reinforcementsent) then {
_wptype = "HOLD";
_wpformation = "WEDGE";
} else {
_wptype = "MOVE";
_wpformation = "WEDGE";
};
} else {
_Behaviour =  "SAFE"; 
_speedmode = "FULL";
_unitpos = "AUTO";
_minreact = KRON_UPS_minreact * 3;
if (((_nomove=="NOMOVE") || (_nomove=="MOVE" && _rnd < 70)) && !_reinforcementsent) then {
_wptype = "HOLD";
_wpformation = "WEDGE";
}else{
_wptype = "MOVE";
_wpformation = "FILE";  
};
};
};
};
if ( _fortify && random 100 < 99) then {_wptype = "HOLD"};
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
if (vehicle _npc != _npc || !_isman) then {
_wptype = "MOVE";
_Behaviour =  "AWARE"; 
if ( _inheli ) then {
_speedmode = "FULL";
_unitpos = "AUTO";
_targetPos = _AttackPos;
};
};
KRON_targetsPos set [_grpid,_targetPos];
sleep 0.01;
if ( KRON_UPS_useMines && _Mines > 0 ) then {
_enemytanksnear = false;
{
if ( ("Tank" countType [_x] > 0 || "Wheeled_APC" countType [_x] >0 
|| "Tank" countType [vehicle _x] > 0 || "Wheeled_APC" countType [vehicle _x] >0 ) 
&& alive _x && canMove _x && _npc distance _x <= _closeenough + KRON_UPS_safedist )
exitwith { _enemytanksnear = true; _enemytanknear = _x;};
} foreach _targets;
if ( _enemytanksnear && !isnull _enemytanknear && alive _enemytanknear ) then {
_friendlytanksnear = false;
{
if (!( alive _x && canMove _x)) then {_friendlytanks = _friendlytanks - [_x]};
if (alive _x && canMove _x && _npc distance _x <= _closeenough + KRON_UPS_safedist ) exitwith { _friendlytanksnear = true;}; 
}foreach _friendlytanks;
if (!_friendlytanksnear && random(100)<30 ) then {
_dir1 = [_currPos,position _enemytanknear] call KRON_getDirPos;
_mineposition = [position _npc,_dir1, 25] call MON_GetPos2D;
_roads = _mineposition nearroads 50;
if (count _roads > 0) then {_mineposition = position (_roads select 0);};
if ([_npc,_mineposition] call MON_CreateMine) then {
_Mines = _Mines -1;
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1: %3 putting mine for %2",_grpidx,typeof _enemytanknear, side _npc]}; 
};
};
};
};
if (_reinforcementsent) then {
_wptype="MOVE";
_newpos=true; 
_makenewtarget = false;
};
if (_nofollow=="NOFOLLOW" && _wptype != "HOLD") then {
_targetPos = [_targetPos,_centerpos,_rangeX,_rangeY,_areadir] call KRON_stayInside;
_targetdist = [_currPos,_targetPos] call KRON_distancePosSqr;
if ( _targetdist <= 1 ) then {
_wptype="HOLD";
};
};
if (_wptype == "HOLD") then {
_targetPos = _currPos;_targettext ="_currPos";
};
_lastknown = _opfknowval; 
if  (!_newpos) then {
_newpos = _gothit;
if  (!_newpos) then {
_targetPos=_lastpos;
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1 is manitaining orders %2",_grpidx,_nomove]};
};
};
if (KRON_UPS_Debug>=1) then {
"avoid" setmarkerpos _avoidPos; 
"flank" setmarkerpos _flankPos; 
_destname setMarkerPos _targetPos;
};
};
sleep 0.1;
}; 
if !(_newpos) then {
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || {!canmove _npc} || {isplayer _npc} ) exitwith {_exit=true;};
_currpos = getpos _npc;
if (_targetsnear) then{
if (( toUpper(_Behaviour) IN _safemode) && _isSoldier) then {
_Behaviour = "AWARE";
_npc setBehaviour _Behaviour;
};
};
if ((toUpper(_Behaviour) IN _safemode) && _deadBodiesReact)then {
_unitsin = [_npc,_buildingdist] call MON_deadbodies;
if (count _unitsin > 0) then { 
if !_isSoldier then {
_npc setSpeedMode "FULL";
} else {
if ( random 100 < 75) then {
_Behaviour =  "AWARE";
} else {
_Behaviour =  "COMBAT";
};
_react = _react + 30;
_npc setBehaviour _Behaviour;
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1 - dead bodies found! set %2",_grpidx,_Behaviour, count _targets]};
}; 
};
};
if (!_nowp && {alive _npc} && {canmove _npc} && {_wptype == "MOVE"} && {_timeontarget >= 240} && {_lastcurrpos select 0 == _currpos select 0} && {_lastcurrpos select 1 == _currpos select 1}) then {
[_npc] call MON_cancelstop;
_makenewtarget = true;
if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_DEBUG: Group %1 (%2) is stuck, moving. Reason: _timeontarget = %3, _lastcurrpos select 0 == _currpos select 0: %4, _lastcurrpos select 1 == _currpos select 1: %5, _lastcurrpos = %6, _currpos = %7",_grpidx,_npc,_timeontarget,(_lastcurrpos select 0 == _currpos select 0),(_lastcurrpos select 1 == _currpos select 1),_lastcurrpos,_currpos]};
};
_lastpos = _targetPos;
_lastcurrpos = _currpos; 
if (_waiting<0) then {
_targetdist = [_currPos,_targetPos] call KRON_distancePosSqr;
if (_fightmode!="walk") then {
if (_timeontarget > KRON_UPS_alerttime && {count _targets <= 0} && {( isNull (_target) || !alive (_target) || captive _target)}) then {
_pursue = false;
_gothit = false;
_targetdead= true;
_fightmode = "walk";
_npc setVariable ["SAR_fightmode",_fightmode,false];
_speedmode = _orgSpeed;
_targetPos = _currPos;
_reinforcementsent = false;
_target = objnull;
_fixedtargetPos = [0,0];
_Behaviour = _orgMode;
_waiting = -1;
_unitpos = "AUTO";
_wpformation = "WEDGE";
KRON_UPS_reinforcement = false; 
if (_rfid > 0 ) then {
call (compile format ["KRON_UPS_reinforcement%1 = false;",_rfid]);
};
{[_x,"AUTO"] spawn MON_setUnitPos;}foreach units _npc;
_npc setBehaviour _orgMode;
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: group %1: Without objectives/targets, leaving combat mode",_grpidx]};
};
};
if(_targetdist <= (_area/4) && (_fightmode == "walk")) then {  
if(_iscar || _isboat || _isplane) then {
_timeonwaypoint = KRON_UPS_wp_maxwaiting;
} else {
_timeonwaypoint = _timeonwaypoint + _currcycle;
if(!_circle_up && (random 100 < 25)) then { 
[_npc,"defend",10] spawn SAR_circle_static;
_circle_up = true;
};
};
};
if (!_nowp && {(!_gothit)} && {(!_swimming)} && {(_fightmode == "walk")} && {(( _targetdist <= (_area/4) || moveToFailed _npc) && (_timeonwaypoint >= KRON_UPS_wp_maxwaiting))}) then {
if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_Debug: Group %1 is getting a new waypoint!",_grpidx]};
if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_Debug: reason: _targetdist < area/4: %1, _timeontarget condition: %2, _timeontarget: %3, _timeonwaypoint: %4",( _targetdist <= (_area/4) || moveToFailed _npc),_timeontarget > KRON_UPS_maxwaiting,_timeontarget,_timeonwaypoint]};
_makenewtarget=true;
_unitpos = "AUTO";
_Behaviour = _orgMode;
} else { 
if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_Debug: Group %6 did NOT get a new waypoint. Potential reason: _fightmode = %1, _timeontarget = %2,_targetdist = %3, _area/4 = %4, _timeonwaypoint = %5",_fightmode,_timeontarget,_targetdist,_area/4,_timeonwaypoint,_grpidx]};
if(_fightmode == "fight" && _circle_up) then {
[group _npc] call SAR_break_circle;
if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_Debug: Group %1 did break out of a circle condition.",_grpidx]};
};
};
if (_makenewtarget) then 
{
_gothit = false;
_react = 0;
_lastreact = 0;
_makenewtarget = false;
_timeontarget = 0;
_timeonwaypoint = 0;
_wptype = "MOVE";
if(_circle_up) then {
[group _npc] call SAR_break_circle;
_circle_up = false;
};
if (format ["%1",_fixedtargetPos] !="[0,0]") then {
_targetPos = _fixedtargetPos; 
_targettext ="Reinforcement";
} else {
if ((_nomove=="NOMOVE") && {(_timeontarget>KRON_UPS_alerttime)}) then {
if (KRON_UPS_WP_Debug>0) then {diag_log format["nomove: %1",_nomove]};
if (([_currPos,_orgPos] call KRON_distancePosSqr)<_closeenough) then {
_newpos = false;
_wptype = "HOLD";
_waiting = 9999;
if (_fortify) then {
_minreact = KRON_UPS_minreact * 3;
_buildingdist = _buildingdist * 2;
_wait = 3000;
};
} else {
_targetPos=_orgPos; _targettext ="_orgPos";
};
} else {
_rcurrPos = getpos _npc;
if (_rlastPos select 0 == _rcurrPos select 0 && {_rlastPos select 1 == _rcurrPos select 1}) then {
if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_DEBUG: %1 !RstuckControl try to move",_grpidx]};
if (vehicle _npc != _npc) then {
_rstuckControl = _rstuckControl + 1;
if (_rstuckControl > 1) then {
_jumpers = crew (vehicle _npc);
{
_x spawn MON_doGetOut;
sleep 0.5;
} forEach _jumpers;
} else {
nul = [vehicle _npc] spawn MON_domove;
};
} else {
nul = [_npc,25] spawn MON_domove;
};
} else {
_rstuckControl = 0;
};
_rlastPos = _rcurrPos;
_centerpos = getMarkerPos _areamarker; 
_centerX = abs(_centerpos select 0); 
_centerY = abs(_centerpos select 1);
_centerpos = [_centerX,_centerY];
_areasize = getMarkerSize _areamarker; 
_rangeX = _areasize select 0; 
_rangeY = _areasize select 1;
_areadir = (markerDir _areamarker) * -1;
_targetPos=_currPos; 
_targettext ="newTarget";
_tries=0;
while {((([_currPos,_targetPos] call KRON_distancePosSqr) < _mindist)) && (_tries<50)} do {
_tries=_tries+1;
_targetPos = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
_loop2=FALSE;
if (_isplane || _isboat) then {
if (_isboat) then {
_tries2=0; 
while {(!_loop2) && (_tries2 <50)} do {
_tries2=_tries2+1;
_targetPosTemp = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
if (surfaceIsWater _targetPosTemp) then {
_targetPos = _targetPosTemp; 
_loop2 = TRUE;
};
sleep 0.05;
};
} else {
_targetPos = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
};
} else { 
if _onroad then {
_tries2=0; 
while {(!_loop2) && (_tries2 <100)} do {
_tries2=_tries2+1;
_targetPosTemp = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
_roads = (_targetPosTemp nearRoads 50); 
if ((count _roads) > 0) then {
_targetPosTemp = getpos (_roads select 0);
_targetPos = _targetPosTemp;
if(([_currPos,_targetPos] call KRON_distancePosSqr) > _mindist) then {
_loop2 = TRUE;
if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_Debug: Group %1 - land vehicle group - just got a new onroad waypoint: %2, after %3 tries",_grpidx,_targetPos,_tries2]};
};
};
sleep 0.05;
};
} else {
_tries2=0; 
while {(!_loop2) && (_tries2 <100)} do {
_tries2=_tries2+1;
_targetPosTemp = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
if (!surfaceIsWater _targetPosTemp) then {
_targetPos = _targetPosTemp; 
_loop2 = TRUE;
if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_Debug: Group %1 Man just got new TP %2, after %3 tries.",_grpidx,_targetPos,_tries2]};
};
sleep 0.05;
};
};
};
};
};
};
sleep 0.05;
_avoidPos = [0,0]; 
_flankPos = [0,0]; 
_attackPos = [0,0];
_frontPos = [0,0];
_fm=0;
_newpos=true;
};
};
};
if (surfaceIsWater _currPos) then {
if (_isman && !_swimming) then {
_drydist=999;
for [{_a=0}, {_a<=270}, {_a=_a+90}] do {
_dp=[_currPos,30,_a] call KRON_relPos; 
if !(surfaceIsWater _dp) then {_targetPos=_dp};
};
_newpos=true; 
_swimming=true;
};
} else {
_swimming=false;
};
sleep 0.5;
if ((_waiting<=0) && _newpos) then {
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
_currPos = getpos _npc;
_newpos = false;
_waiting = -1; 
_swimming=false;
_GetIn_NearestVehicles = false;
_targetdist = [_currPos,_targetPos] call KRON_distancePosSqr;
if (_gothit && _npc == vehicle (_npc) && alive _npc ) then {
if ((random 100) <50) then {
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1 supressed by fire",_grpidx]};
_supressed = true;
_targetPos = _currPos;
_targettext ="SUPRESSED";
_wptype = "HOLD";
{
if ( _x iskindof "Man" && canmove _x && alive _x) then {
if ((random 100)<40 || (primaryWeapon _x ) in KRON_UPS_MG_WEAPONS) then {
[_x,"DOWN",20] spawn MON_setUnitPosTime;
}else{
[_x,"Middle"] spawn MON_setUnitPos;};
};
sleep 0.01;
} foreach units _npc;
if ((random 100)<=60 && morale _npc < 0) then {
_targetPos = _avoidPos;
_targettext = "_avoidPos";
_wptype = "MOVE";
_flankdir = 0;
if (!_newpos && KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_Debug: Group %1 All Retreat!!!",_grpidx]};
};
};
 
if ((random 100) < 15 && _targettext == "_avoidPos" && !_nosmoke) then {
[_npc,_target] call MON_throw_grenade;
};
sleep 0.5;
};
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
if (alive _npc) then {
_currPos = getpos _npc;
if ( _wptype == "MOVE") then {
if ( _npc == vehicle _npc) then {
{
if (alive _x && canmove _x) then {
[_x] dofollow _npc;
};
} foreach _members;
};
sleep 0.05;
if ((!_gothit && _targetdist >= ( KRON_UPS_searchVehicledist )) && _isSoldier && !_noveh) then {
if ( vehicle _npc == _npc && _dist > _closeenough ) then {
 _unitsIn = [_grpid,_npc] call MON_GetIn_NearestVehicles;
 
if ( count _unitsIn > 0) then {
_GetIn_NearestVehicles = true;
_speedmode = "FULL";
_unitpos = "AUTO";
_npc setbehaviour "SAFE";
_npc setspeedmode "FULL";
_timeout = time + 60;
_vehicle = objnull;
_vehicles = [];
{ 
waituntil {vehicle _x != _x || !canmove _x || !canstand _x || !alive _x || time > _timeout || movetofailed _x}; 
if ( vehicle _x != _x && (isnull _vehicle || _vehicle != vehicle _x)) then {
_vehicle = vehicle _x ;
_vehicles = _vehicles + [_vehicle]
};
}foreach _unitsIn;
sleep 1;
{
_vehicle = _x;
_cargo = _vehicle getvariable ("UPSMON_cargo");
if ( isNil("_cargo")) then {_cargo = [];};
_cargo ordergetin true;
{ 
waituntil {vehicle _x != _x || !canmove _x || !canstand _x || !alive _x || time > _timeout || movetofailed _x}; 
} foreach _cargo;
nul = [_vehicle] spawn MON_Gunnercontrol;
sleep 0.1;
} foreach _vehicles;
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc) exitwith {_exit=true;};
if ( "Air" countType [vehicle (_npc)]>0) then {
_rnd = (random 2) * 0.1;
_flyInHeight = round(KRON_UPS_flyInHeight * (0.9 + _rnd));
vehicle _npc flyInHeight _flyInHeight;
if (_GetIn_NearestVehicles) then { 
_GetOutDist = round(((KRON_UPS_paradropdist )  * (random 100) / 100 ) + 150);
[vehicle _npc, _TargetPos, _GetOutDist, 90] spawn MON_doParadrop; 
sleep 1;
[vehicle _npc] spawn MON_HeliStuckcontrol;
if (KRON_UPS_WP_Debug>0 ) then {diag_log format["%1: flyingheight=%2 paradrop at dist=%3",_grpidx, _flyInHeight, _GetOutDist,_rnd]}; 
};
};
};
};
};
};
sleep 0.05;
if (!_gothit && !_GetIn_NearestVehicles && _fightmode != "walk" && _isSoldier && !_noveh) then {
_dist2 = _dist / 4;
if ( _dist2 <= 100 ) then {
_unitsIn = [];
_unitsIn = [_grpid,_npc,_dist2,false] call MON_GetIn_NearestCombat;
_timeout = time + (_dist2/2);
if ( count _unitsIn > 0) then {
if (KRON_UPS_AI_Debug>0 ) then {diag_log format["KRON_UPS_AI_Debug: Group %1: Getting in combat vehicle targetdist=%2",_grpidx,_npc distance _target]}; 
_npc setbehaviour "SAFE";
_npc setspeedmode "FULL";
{ 
waituntil {vehicle _x != _x || !canmove _x || !canstand _x || !alive _x || time > _timeout || movetofailed _x}; 
}foreach _unitsIn;
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
_npc setbehaviour _Behaviour;
_timeout = time + 150;
{ 
waituntil {vehicle _x != _x || !canmove _x || !alive _x || time > _timeout || movetofailed _x}; 
}foreach _unitsIn;
{
if ( vehicle _x  iskindof "Air") then {
if (driver vehicle _x == _x) then {
_vehicle = vehicle (_x);
nul = [_vehicle,1000] spawn MON_domove;
[_vehicle] spawn MON_HeliStuckcontrol;
if (KRON_UPS_AI_Debug>0 ) then {diag_log format["KRON_UPS_AI_DEBUG: Group %1: Getting in combat vehicle, distance %2",_grpidx,_npc distance _target]}; 
};
};
if (driver vehicle _x == _x) then {
nul = [vehicle _x] spawn MON_Gunnercontrol;
};
sleep 0.01;
}foreach _unitsIn;
};
};
};
sleep 0.05;
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
if ((KRON_UPS_useStatics && (vehicle _npc == _npc) && !_GetIn_NearestVehicles && _isSoldier ) && ((_wptype == "HOLD" && (random 100) < 80) || (_wptype != "HOLD" && (random 100) < 60))) then {
 _unitsIn = [_grpid,_npc,_buildingdist] call MON_GetIn_NearestStatic;
if ( count _unitsIn > 0) then {
_npc setbehaviour "SAFE";
_npc setspeedmode "FULL";
_timeout = time + 60;
{ 
waituntil {vehicle _x != _x || !canmove _x || !alive _x || time > _timeout || movetofailed _x}; 
}foreach _unitsIn;
};
sleep 0.05;
};
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
if (_circledefend && {(_targetdist <=  _closeenough)}) then { 
_nomove="NOMOVE";
_minreact = KRON_UPS_minreact * 3;
_buildingdist = _buildingdist / 2;
_makenewtarget = false;
_wait = 3000;
};
if (!_GetIn_NearestVehicles) then {
if ( _wptype == "HOLD" && {vehicle _npc == _npc} && {( _fortify ||(random 100) < 60)} && {!_circledefend}) then {
if (KRON_UPS_AI_Debug>0) then {diag_log format["KRON_UPS_AI_DEBUG: Group %1: Moving to nearest buildings",_grpidx]}; 
[_npc,_buildingdist,false,_wait] spawn MON_moveNearestBuildings;
} else {
if ((( _wptype != "HOLD" && vehicle _npc == _npc && (random 100) < 90  ) && _npc == vehicle _npc && _dist <= ( _closeenough ))) then {
[_npc,_buildingdist,true] spawn MON_moveNearestBuildings;
};
};
sleep 0.05;
};
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
if (isnull _grp || _grp != group _npc) then {
_grp = group _npc;
};
_index = currentWaypoint _grp;
if (_wptype != "HOLD" || _lastwptype != _wptype) then {
if ( _index == 1 || _index > count waypoints _grp && !isnull _grp) then {
_wp = _grp addWaypoint [_targetPos, 0];
_index = _wp select 1;
 if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_Debug: Group %1: created wp %2 index %3 at %4",_grpidx,_wp, _index,_targetPos]};
} else {
if ( _index == 0 ) then {
_wp = _grp addWaypoint [_targetPos, 0];
_index = _wp select 1;
if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_Debug: Group %1: 0 wp issue: created wp %2 index %3 at %4",_grpidx,_wp, _index,_targetPos]};
} else {
_wp = [_grp,_index];
if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_Debug: Group %1: did NOT create a wp %2 index %3 %4",_grpidx,_wp, _index,_targetPos]}; 
};
};
};
if ((!_gothit && _targetdist >= (_closeenough * 1.5)) && (vehicle _npc != _npc)) then {
_speedmode = "FULL";
} else { 
_speedmode = _orgSpeed;
};
_wp  setWaypointType _wptype;
_wp  setWaypointPosition [_targetPos, 0];
_wp  setWaypointFormation _wpformation;
_wp  setWaypointSpeed _speedmode;
_lastwptype = _wptype;
{
if ( _x select 1 < _index ) then {
deleteWaypoint _x;
};
sleep 0.05;
} foreach waypoints _grp;
if (KRON_UPS_WP_Debug>0) then {diag_log format["KRON_UPS_WP_Debug: Group %1: waypoints %2",_grpidx,count waypoints _grp]};
if (toupper(behaviour _npc) != toupper (_Behaviour)) then {
_npc setBehaviour _Behaviour;
};
KRON_targetsPos set [_grpid,_targetPos];
{
if ((random 100)<95 && _x == vehicle _x && _x iskindof "Man" && !((primaryWeapon _x ) in KRON_UPS_MG_WEAPONS)) then {
nul = [_x,_unitpos] spawn MON_setUnitPos;
}else{
nul = [_x,"AUTO"] spawn MON_setUnitPos;
};
} foreach units _npc;
if (_gothit || _dist <= _closeenough) then {
{
if (!canStand _x || ((primaryWeapon _x ) in KRON_UPS_MG_WEAPONS) || (vehicle _x == _x && _x iskindof "Man" && (random 100) < 50) ) then {
_x suppressFor 15;
};
} foreach units _npc;
};
};
_gothit = false;
};
if (_track=="TRACK") then { 
switch (_fm) do {
case 1: 
{_destname setmarkerSize [.4,.4]};
case 2: 
{_destname setmarkerSize [.6,.6]};
default
{_destname setmarkerSize [.5,.5]};
};
_destname setMarkerPos _targetPos;
};
if (_isplane || _inheli) then {
_currcycle = _cycle/2;
_flyInHeight = KRON_UPS_flyInHeight;
vehicle _npc flyInHeight _flyInHeight;
};
   
_cont = 1;
_npcname = vehicleVarname _npc;
_cont = (call compile format ["KRON_UPS_%1",_npcname]);
if(SAR_DEBUG) then {diag_log format ["_cont = %1 for leader: %2", _cont, format ["KRON_UPS_%1",_npcname]];};
if (_cont==0) then { 
_exit=true;
};
if ((_exit) || (isNil("_npc"))) then {
_loop=false;
} else {
sleep _currcycle;
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
if (isnull _grp || _grp != group _npc) then {
_grp = group _npc;
};
};
/*if (_cont==2) then { 
diag_log "SARGE: UPSMON suspended";
doStop _npc;
_oldbehaviour = behaviour _npc;
_looping = true;
while {_looping} do {
sleep 1;
   _cont = (call compile format ["KRON_UPS_%1",_npcname]);
if (_cont==1) then { 
_looping=false;
};
};
_npc = [_npc,_members] call MON_getleader;
if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};
if (isnull _grp || _grp != group _npc) then {
_grp = group _npc;
};
{
_x enableAI "MOVE";
_x enableAI "TARGET";
_x forceSpeed -1;
_x setbehaviour _oldbehaviour;
} foreach units (group _npc);
};
  */  
};
KRON_targetsPos set [_grpid,[0,0]];
KRON_NPCs set [_grpid,objnull];
KRON_UPS_Exited=KRON_UPS_Exited+1;
if (_track=="TRACK") then {
_trackername setMarkerType "Empty";
_destname setMarkerType "Empty";
};
if (!isnull _target) then {
_dist = ([_orgpos,position _target] call KRON_distancePosSqr);
};
if (_respawn && {_respawnmax > 0} &&  {!_surrended}) then {
{
deletevehicle _x;
}foreach _vehicles;
sleep _respawntime;
if (KRON_UPS_Debug>0) then {diag_log format["KRON_UPS_DEBUG: Starting respawn logic for Group %1.",_grpidx]};
_allow_respawn = true;
_gridspawn = [_areamarker,9] call KRON_StrLeft;
if(_gridspawn == "SAR_area_" && SAR_dynamic_group_respawn) then {
private ["_tmparr","_triggername","_unitcheck"];
_tmparr=toArray (_areamarker);
_tmparr set[4,116];
_tmparr set[5,114];
_tmparr set[6,105];
_tmparr set[7,103];
_triggername = toString _tmparr;
Call Compile Format ["_unitcheck = triggerActivated %1 ",_triggername];
if (!_unitcheck) then { 
_allow_respawn = false;
if(SAR_DEBUG) then {diag_log format["SAR_DEBUG: Trigger is deactivated, deny respawn for a dynamic group!",_unitcheck];};
};
};
if(_allow_respawn) then {   
_unittype = _membertypes select 0;
_grouptype = "";
_type = "";
if (_unittype in SAR_leader_sold_list) then {
_grouptype = "soldiers";
_type="sold";
_ai_type = "AI Military";
} else {
if (_unittype in SAR_leader_surv_list) then {
_grouptype = "survivors";
_type="surv";
_ai_type = "AI Survivor";
} else {
if (_unittype in SAR_leader_band_list) then {
_grouptype = "bandits";
_type="band";
_ai_type = "AI Bandit";
};
};
};
_is_veh_group=false;
if(count _vehicletypes > 0) then {
_is_veh_group=true;
};
_group = createGroup _side;
_group setVariable ["SAR_protect",true,true];
if (_iscar) then {
_tries2=0;
_loop2 = false;
while {(!_loop2) && (_tries2 <100)} do {
_tries2=_tries2+1;
_targetPosTemp = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
_roads = (_targetPosTemp nearRoads 50); 
if ((count _roads) > 0) then {
_targetPosTemp = getpos (_roads select 0);
_orgPos = _targetPosTemp;
_loop2 = TRUE;
if (KRON_UPS_Debug>0) then {diag_log format["KRON_UPS_Debug: Group %1 - land vehicle group respawn- got a new onroad spawnpoint: %2, after %3 tries",_grpidx,_orgPos,_tries2]};
};
sleep 0.05;
};
} else {
_orgpos = [_areamarker] call SHK_pos;
};
_leader = _group createUnit [_unittype, _orgpos, [], 0, "form"];
_leader allowDamage false;
[nil, _leader, "per", rHideObject, true] call RE; 
_leader disableAI "FSM";
_leaderskills = call compile format ["SAR_leader_%1_skills",_type];
_leader_weapon_names = ["leader",_type] call SAR_unit_loadout_weapons;
_leader_items = ["leader",_type] call SAR_unit_loadout_items;
_leader_tools = ["leader",_type] call SAR_unit_loadout_tools;
[_leader,_leader_weapon_names,_leader_items,_leader_tools] call SAR_unit_loadout;
{
_leader setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
} foreach _leaderskills;
if(_is_veh_group) then {
_leader setVehicleInit "[this] spawn SAR_AI_trace_veh;this setIdentity 'id_SAR_sold_lead';[this] spawn SAR_AI_reammo;";
} else {
_leader setVehicleInit "[this] spawn SAR_AI_trace;this setIdentity 'id_SAR_sold_lead';[this] spawn SAR_AI_reammo;";
};
_leader addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*SAR_leader_health_factor}}];
_leader addMPEventHandler ["MPkilled", {Null = _this spawn SAR_AI_killed;}]; 
_leader addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}];
_cond="(side _this == west) && (side _target == SAR_AI_friendly_side) && ('ItemBloodbag' in magazines _this)";
[nil,_leader,rADDACTION,"Give me a blood transfusion!", "addons\SARGE\SAR_interact.sqf","",1,true,true,"",_cond] call RE;
 
[_leader] joinSilent _group;
_leadername = format["SAR_leader_%1",_grpidx];
_leader setVariable ["SAR_leader_name",_leadername,false];
_leader setVehicleVarname _leadername;
if(!_is_veh_group) then {
if(SAR_DEBUG) then {
[_leader] spawn SAR_AI_debug;
};
};
_leader setVariable ["SAR_AI_type",_ai_type + " Leader",false];
_leader setVariable ["SAR_AI_experience",0,false];
_leader setVariable ["UPSMON_grpid", _grpidx, false];
_leader setspeedmode "FULL";
_leader setBehaviour "SAFE"; 
call compile format ["KRON_UPS_%1=1",_leadername];
_group selectLeader _leader;
if(KRON_UPS_DEBUG>0) then {diag_log format["KRON_UPS_DEBUG: Group %3 respawned a leader unit %1 at %2",(typeOf _leader),getPos _leader,_grpidx];};
_i=0;
{
_i=_i+1;
if (_i>1) then {
_newunit = _group createUnit [_x, _orgpos, [],0,"form"];
_newunit allowDamage false;
[nil, _newunit, "per", rHideObject, true] call RE; 
_newunit disableAI "FSM";
switch (_grouptype) do {
case "soldiers":
{
if (_x in SAR_soldier_sold_list) then {
_unittype = "soldier";
_loadouttype = "rifleman";
};
if (_x in SAR_sniper_sold_list) then {
_unittype = "sniper";
_loadouttype = "sniper";
};
};
case "survivors":
{
if (_x in SAR_soldier_surv_list) then {
_unittype = "soldier";
_loadouttype = "rifleman";
};
if (_x in SAR_sniper_surv_list) then {
_unittype = "sniper";
_loadouttype = "sniper";
};
};
case "bandits":
{
if (_x in SAR_soldier_band_list) then {
_unittype = "soldier";
_loadouttype = "rifleman";
};
if (_x in SAR_sniper_band_list) then {
_unittype = "sniper";
_loadouttype = "sniper";
};
};
};
_unit_weapon_names = [_loadouttype,_type] call SAR_unit_loadout_weapons;
_unit_items = [_loadouttype,_type] call SAR_unit_loadout_items;
_unit_tools = [_loadouttype,_type] call SAR_unit_loadout_tools;
_unit_skills = call compile format ["SAR_%2_%1_skills",_type,_unittype];
[_newunit,_unit_weapon_names,_unit_items,_unit_tools] call SAR_unit_loadout;
{
_newunit setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
} foreach _unit_skills;
if(_is_veh_group) then {
_newunit setVehicleInit "[this] spawn SAR_AI_trace_veh;this setIdentity 'id_SAR';[this] spawn SAR_AI_reammo;";
} else {
_newunit setVehicleInit "[this] spawn SAR_AI_trace;this setIdentity 'id_SAR';[this] spawn SAR_AI_reammo;";
};
_newunit addMPEventHandler ["MPkilled", {Null = _this spawn SAR_AI_killed;}]; 
_newunit addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}]; 
_newunit addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*1}}];
_newunit setVariable ["SAR_AI_type",_ai_type,false];
_newunit setVariable ["SAR_AI_experience",0,false];
[_newunit] joinSilent _group;
if(KRON_UPS_DEBUG>0) then {diag_log format["KRON_UPS_DEBUG: Group %2 respawned a group unit %3, of type %1",_x,_grpidx,_newunit];};
sleep 0.1;
};
} foreach _membertypes;
_gridspawn = [_areamarker,9] call KRON_StrLeft;
if(_gridspawn == "SAR_area_") then {
if (SAR_EXTREME_DEBUG) then {
diag_log "SAR EXTREME DEBUG: Content of the Monitor before adding respawned groups.";
call SAR_DEBUG_mon;
};
_valuearray= [["grps_band","grps_sold","grps_surv"],_areamarker] call SAR_AI_mon_read; 
_grps_band=_valuearray select 0;
_grps_sold=_valuearray select 1;
_grps_surv=_valuearray select 2;
_grps_upd =[];
switch (_grouptype) do {
case "soldiers":
{
_grps_upd = _grps_sold;
_grps_upd set [count _grps_upd,_group];
_check = [["grps_sold"],[_grps_upd],_areamarker] call SAR_AI_mon_upd;
};
case "survivors":
{
_grps_upd = _grps_surv;
_grps_upd set [count _grps_upd,_group];
_check = [["grps_surv"],[_grps_upd],_areamarker] call SAR_AI_mon_upd;
};
case "bandits":
{
_grps_upd = _grps_band;
_grps_upd set [count _grps_upd,_group];
_check = [["grps_band"],[_grps_upd],_areamarker] call SAR_AI_mon_upd;
};
};
if (SAR_EXTREME_DEBUG) then {
diag_log "SAR EXTREME DEBUG: Content of the Monitor AFTER adding respawned groups.";
call SAR_DEBUG_mon;
};
};
if ( _leader == vehicle _leader) then {
{
if (alive _x && canmove _x) then {
[_x] dofollow _leader;
};
sleep 0.1;
} foreach units _leader;
};
_tmp_veh_units = units _leader;
_tmp_count_units = 0;
{
_tmp_vehicle_number = _forEachIndex;
if (_iscar) then {
_targetpos = _orgpos findEmptyPosition [10, 200];
sleep .4;
if (count _targetpos <= 0) then {
_targetpos = _orgpos;
diag_log "No position for land vehicle found, back to default position";
};
} else {
_targetpos = _orgpos;
};
if (KRON_UPS_Debug>0) then {diag_log format["KRON_UPS_Debug: Group %1 respawn - creating a new vehicle %2 at %3 ",_grpidx, _x,_targetpos]};
if (_iscar) then {
_veh = createVehicle [_x, [_orgpos select 0, _orgpos select 1, 0], [], 0, "FORM"];
} else {
_veh = createVehicle [_x, [_orgpos select 0, _orgpos select 1, 80], [], 0, "FLY"];
};
_veh setFuel 1;
_veh setVariable ["Sarge",1,true];
_veh engineon true; 
if(_isplane) then {
_veh setVehicleAmmo 1;
};
if(_iscar) then {
_veh addEventHandler ["HandleDamage", {_this spawn SAR_AI_VEH_HIT;_this select 2;}];  
}else{
if(SAR_heli_shield) then {
_veh addEventHandler ["HandleDamage", {returnvalue = _this spawn SAR_AI_VEH_HIT;}];  
}else {
_veh addEventHandler ["HandleDamage", {_this spawn SAR_AI_VEH_HIT;_this select 2;}];  
};
};
[_veh] joinSilent _group;
if(_iscar) then {
_tmp_cargo_units = count (_vehiclecrews select _tmp_vehicle_number);
_tmp_count_units = _tmp_count_units + _tmp_cargo_units;
if(_tmp_vehicle_number == 0) then {
_leader moveInDriver _veh;
_leader assignAsDriver _veh;
for "_i" from 1 to (_tmp_count_units - 1) do {
(_tmp_veh_units select _i)  moveInCargo _veh;
(_tmp_veh_units select _i) assignAsCargo _veh;
};
} else {
(_tmp_veh_units select (_tmp_count_units - _tmp_cargo_units)) moveInDriver _veh;
(_tmp_veh_units select (_tmp_count_units - _tmp_cargo_units)) assignAsDriver _veh;
for "_i" from (_tmp_count_units - (_tmp_cargo_units - 1)) to (_tmp_count_units - 1) do {
(_tmp_veh_units select _i)  moveInCargo _veh;
(_tmp_veh_units select _i) assignAsCargo _veh;
};
};
};
if(_isplane) then {
{
if(_foreachIndex > 0) then {
_x moveInTurret [_veh,[0]];
} else {
_x moveindriver _veh;
};
} foreach units _leader;
};
} foreach _vehicletypes;
if (!_spawned) then { 
_UCthis = _UCthis + ["SPAWNED"];
if ((count _vehicletypes) > 0) then {
_UCthis = _UCthis + ["VEHTYPE:"] + ["dummyveh"];
};
};
_UCthis set [0,_leader];
_respawnmax = _respawnmax - 1;
_UCthis =  ["RESPAWN:",_respawnmax,_UCthis] call KRON_UPSsetArg;
sleep 0.1;
_UCthis =  ["VEHTYPE:",_vehicletypes,_UCthis] call KRON_UPSsetArg;
_UCthis spawn SAR_AI_UPSMON;
sleep 0.1;
processInitCommands;
};
};
_friends=nil;
_enemies=nil;
_enemytanks = nil;
_friendlytanks = nil;
_roads = nil;
_targets = nil;
_members = nil;
_membertypes = nil;
_UCthis = nil;
if (!alive _npc) then {
deleteGroup _grp;
};