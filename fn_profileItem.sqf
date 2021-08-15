
params ["_object", ["_simulation", false, [false]]];

private _classname = typeOf _object;
private _postion   = getPosASL _object;
private _vectorUp  = vectorUp _object;
private _vectorDir = vectorDir _object;

private _triggerSize = 300;

deleteVehicle _object;

private _onAct    = format ["_data = thisTrigger getVariable 'profileData'; _veh = createVehicle ['%1', %2, [], 0, 'CAN_COLLIDE']; [{_this#0 setVectorDirAndUp [%3, %4]; _this#0 setPosASL _this#1; _this#0 enableSimulation _this#2;}, [_veh, %2, %5]] call CBA_fnc_execNextFrame; thisTrigger setVariable ['profile', _veh call BIS_fnc_netId]", _classname, _postion, _vectorDir, _vectorUp, _simulation];
private _onDeact  = "_obj = thisTrigger getVariable 'profile'; deleteVehicle (_obj call BIS_fnc_objectFromNetId);";

private _trigger = createTrigger ["EmptyDetector", _postion];
_trigger setTriggerArea [_triggerSize, _triggerSize, 0, false, 30];
_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trigger setTriggerStatements ["this", _onAct, _onDeact];
