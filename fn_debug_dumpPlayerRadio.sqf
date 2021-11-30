/*
 * Author: CPL.Brostrom.A
 * This function dump all radios with their ID used by players in the RPT and chat.
 * This function can be executed globaly within the function by passing true as first argument.
 * Run this function in a debug console localy or on server
 *
 * Arguments:
 * 0: Execute Globaly <BOOL> (Optional)
 *
 * Example:
 * execVM "scripts\fn_debug_dumpPlayerRadio.sqf";
 * [true] execVM "scripts\fn_debug_dumpPlayerRadio.sqf";
 *
 */
 
params [["_global", false, [true]]];

private _fnc = {
    if (isServer) exitWith {};
    [format["%1; %2 (%3)", name player, netId player, typeOf player]] remoteExec ["systemChat", -2]; 
    { 
        _radio = _x; 
        _radioArray = [_radio] call acre_api_fnc_getAllRadiosByType; 
        if ((count _radioArray) > 0 ) then { 
            [format["%1 (Size: %2)", _radioArray, (count _radioArray)]] remoteExec ["systemChat", -2]; 
            [formatText["%1: %2 (Size: %3)", name player, _radioArray, (count _radioArray)], "RADIO", false, true, "DEBUG"] call cScripts_fnc_log;
        }; 
    } forEach ["ACRE_SEM52SL","ACRE_SEM70","ACRE_PRC117F","ACRE_PRC148","ACRE_PRC152","ACRE_PRC343","ACRE_PRC77"]; 
    [str "---"] remoteExec ["systemChat", -2];
};

if (_global) then {
    _fnc remoteExec ["call", -2];
} else {
   call _fnc;
};
