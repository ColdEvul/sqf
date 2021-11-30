/*
 * Author: CPL.Brostrom.A
 * This function removes and recreates a given unit as a agent when in proximity.
 * Run this function in the object or unit init.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Example:
 * this execVM "scripts\fn_profileAsAgent.sqf"
 *
 */

params [["_object", objNull, [objNull]]];

private _classname = typeOf _object;
private _postion   = getPosASL _object;
private _vectorUp  = vectorUp _object;
private _vectorDir = vectorDir _object;

private _triggerSize = 800;

deleteVehicle _object;

private _onAct    = format ["_veh = createAgent ['%1', %2, [], 0, 'CAN_COLLIDE']; [{_this#0 setVectorDirAndUp [%3, %4]; _this#0 setPosASL _this#1;}, [_veh, %2]] call CBA_fnc_execNextFrame; thisTrigger setVariable ['profile', _veh call BIS_fnc_netId]", _classname, _postion, _vectorDir, _vectorUp];
private _onDeact  = format ["_obj = thisTrigger getVariable 'profile'; deleteVehicle (_obj call BIS_fnc_objectFromNetId);", _classname];

private _trigger = createTrigger ["EmptyDetector", _postion];
_trigger setVariable ['profileData', [_classname, _postion, [_vectorUp, _vectorDir]]];
_trigger setTriggerArea [_triggerSize, _triggerSize, 0, false, 60];
_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trigger setTriggerStatements ["this", _onAct, _onDeact];
