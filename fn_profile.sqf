/*
 * Author: CPL.Brostrom.A
 * This function removes and recreates a given object or vehicle is in proximity.
 * Run this function in the object or unit init.
 *
 * Arguments:
 * 0: Object or Empty Vehicle <OBJECT>
 *
 * Example:
 * this execVM "scripts\fn_profile.sqf"
 *
 */

params [["_object", objNull, [objNull]]];

private _classname = typeOf _object;
private _postion   = getPosASL _object;
private _vectorUp  = vectorUp _object;
private _vectorDir = vectorDir _object;

private _triggerSize = 1200;

deleteVehicle _object;

private _onAct    = format ["_data = thisTrigger getVariable 'profileData'; _veh = createVehicle ['%1', %2, [], 0, 'CAN_COLLIDE']; [{_this#0 setVectorDirAndUp [%3, %4]; _this#0 setPosASL _this#1}, [_veh, %2]] call CBA_fnc_execNextFrame; thisTrigger setVariable ['profile', _veh call BIS_fnc_netId]", _classname, _postion, _vectorDir, _vectorUp];
private _onDeact  = "_obj = thisTrigger getVariable 'profile'; deleteVehicle (_obj call BIS_fnc_objectFromNetId);";

private _trigger = createTrigger ["EmptyDetector", _postion];
_trigger setTriggerArea [_triggerSize, _triggerSize, 0, false, 200];
_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trigger setTriggerStatements ["this", _onAct, _onDeact];
