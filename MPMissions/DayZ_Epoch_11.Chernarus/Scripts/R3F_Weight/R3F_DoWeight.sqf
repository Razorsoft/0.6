
#include "R3F_WEIGHT_Configuration.cfg"

call compile preprocessFile "Scripts\R3F_Weight\R3F_Weight_Fnct.sqf";

private ["_n","_gearbox_visible","_control","_display","_initial_text"];

disableSerialization;

R3F_Weight = call R3F_WEIGHT_FNCT_GetWeight;

_initial_text = "";
_n = 0;
while {true} do
{
	sleep R3F_WEIGHT_SHORT_DELAY;
	
	#ifdef R3F_WEIGHT_SHOW_WEIGHT
	_display = findDisplay ARMA2_RSCDISPLAYGEARBOX;
	_gearbox_visible = ( (str _display) != "No display");
	#else
	_gearbox_visible = false;
	#endif
	
	if(_gearbox_visible) then {
		R3F_Weight = call R3F_WEIGHT_FNCT_GetWeight;
		if(_initial_text == "") then {
			_control = _display displayCtrl ARMA2_CAPTIONGEARBOX;
			_initial_text = ctrlText _control ;
		};
		_control = _display displayCtrl ARMA2_CAPTIONGEARBOX;
		_control ctrlSetText format[localize "STR_R3F_WEIGHT_InGearBox",_initial_text,R3F_Weight];
		_n = 0;
	}else{
		if( _n > R3F_WEIGHT_LONG_DELAY) then {
			R3F_Weight = call R3F_WEIGHT_FNCT_GetWeight;
			_n = 0;
		};
		_n = _n + 1 ;
	};
};
