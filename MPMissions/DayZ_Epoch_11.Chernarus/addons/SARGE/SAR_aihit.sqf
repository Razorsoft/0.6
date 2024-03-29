
private ["_ai","_aikiller","_aikilled_type","_aikilled_side","_aikilled_group_side","_aikiller_group_side","_aikiller_type","_aikiller_name","_aikiller_side","_humanity","_message"];
_ai = _this select 0;
_aikiller = _this select 1;
_aikilled_type = typeof _ai;
_aikilled_side = side _ai;
_aikilled_group_side = side (group _ai);
_aikiller_type = typeof _aikiller;
if (!(_aikiller_type in SAR_heli_type) && alive _aikiller && !("LandVehicle" countType [vehicle _aikiller]>0)) then {
    _aikiller_name = name _aikiller;
} else {
    _aikiller_name = _aikiller_type;
};
_aikiller_side = side _aikiller;
_aikiller_group_side = side (group _aikiller);
if (SAR_HITKILL_DEBUG && {isServer}) then {
    diag_log format["SAR_HITKILL_DEBUG: AI hit - %2 - Type: %1 Side: %3 Group Side: %4",_aikilled_type,_ai,_aikilled_side,_aikilled_group_side];
    diag_log format["SAR_HITKILL_DEBUG: AI attacker - Type: %1 Name: %2 Side: %3 Group Side: %4",_aikiller_type,_aikiller_name, _aikiller_side,_aikiller_group_side];
};
if(isPlayer _aikiller) then {
    
    if (_aikilled_group_side == SAR_AI_friendly_side) then { 
    
        if(SAR_HITKILL_DEBUG && {isServer})then{diag_log format["SAR_HITKILL_DEBUG: friendly AI was hit by Player %1",_aikiller];};
        
        if ((random 100) < 5) then {
            _message = format["%1, can you please STOP shooting at friendly players ???",_aikiller_name];
            [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
        } else {
            if ((random 100) < 5) then {
                _message = format["%1, this was the last time you shot one of our team! Coming for you!",_aikiller_name];
                [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
            };
        };
        
        _humanity = _aikiller getVariable ["humanity",0];
        _humanity = _humanity - (SAR_surv_kill_value/10);   
        _aikiller setVariable["humanity", _humanity,true];
        
        if(SAR_HITKILL_DEBUG && {isServer})then{diag_log format["SAR_HITKILL_DEBUG: Adjusting humanity for survivor hit by %2 for %1",_aikiller,(SAR_surv_kill_value/10)];};
        
        if((rating _aikiller > -10000) && {!isServer}) then { 
            if(SAR_HITKILL_DEBUG && {isServer})then{diag_log format["SAR_HITKILL_DEBUG: Marking Player %1 as an enemy for a friendly AI hit!",_aikiller];};
            _aikiller addRating -10000;
        };
        group _ai reveal _aikiller;        
        {
            _x doTarget _aikiller;
            _x doFire _aikiller;
        } foreach units group _ai;
    };
    
    
    if (_aikilled_group_side == SAR_AI_unfriendly_side) then { 
    
        if(SAR_HITKILL_DEBUG && {isServer})then{diag_log format["SAR_HITKILL_DEBUG: unfriendly AI was hit by Player %1",_aikiller];};
        _humanity = _aikiller getVariable ["humanity",0];
        _humanity = _humanity + (SAR_band_kill_value/10);
        _aikiller setVariable["humanity", _humanity,true];
        
        if(SAR_HITKILL_DEBUG && {isServer})then{diag_log format["SAR_HITKILL_DEBUG: Adjusting humanity for bandit hit by %2 for %1",_aikiller,(SAR_band_kill_value/10)];};
    
    };
};