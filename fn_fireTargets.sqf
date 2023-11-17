/*
 * Author: CPL.Brostrom.A
 * This function fires 3 rounds on a dynamic or givent target list.
 * The script looks first for objects with the variable name ai_fire_target or with number suffix or targets based on the second parameter.
 *
 * Tip: If the unit do not fire get firemode form a unit using the following command: (getArray (configFile >> "CfgWeapons" >> currentWeapon cursorObject >> "modes"));
 *
 * Run this function on unit init.
 *
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Targets <ARRAY> (Optional)
 * 1: fireMode <String> (Optional)
 *
 * Example:
 * this execVM "scripts\fn_fireTarget.sqf"
 * [bob, [], "Single"] execVM "scripts\fn_fireTarget.sqf"
 * [this [target_1, target_2]] execVM "scripts\fn_fireTarget.sqf"
 * [this [target_1, target_2], "manual", true] execVM "scripts\fn_fireTarget.sqf"
 *
 */
 params [
    ["_unit", objNull, [objNull]],
    ["_assignedTargets", [], [[]]],
    ["_firemode", "Single", [""]],
    ["_doSuppressiveFire", false, [false]]
];

waitUntil { sleep random [4, 5, 6]; true };

private _allTargetItems = allMissionObjects "UserTexture1m_F";

if (_assignedTargets isEqualTo []) then {
    private _targetObjectList = [];
    {
        private _target = [_x] call BIS_fnc_objectVar;
        _target = [_target, 0, 13] call BIS_fnc_trimString;
        _target = toLower _target;
        if (_target == "ai_fire_target") then {
            _targetObjectList append [_x];
        };
    } forEach _allTargetItems;
    _unit setVariable ["ai_fire_target_list", _targetObjectList];
} else {
    _unit setVariable ["ai_fire_target_list", _assignedTargets];
};

private _targetlist = _unit getVariable ["ai_fire_target_list", []];

diag_log format ["Avalible targets %1", _targetlist];

if (_targetlist isEqualTo []) exitWith {
    diag_log format ["ERROR: No targets available for %1 [%2]", _unit, typeof _unit];
};

if (typeOf _unit isKindOf "LandVehicle") then {

    diag_log format ["%1 [%2] is vehicle", _unit, typeof _unit];
    while {alive _unit || _targetlist isEqualTo []} do {
        private _randomTarget = selectRandom _targetlist;
        diag_log format ["%1 [%2] Aquiring target %3", _unit, typeof _unit, _randomTarget];
        gunner _unit doWatch _randomTarget;
    
        waitUntil { sleep random [7,8,9]; true };
        diag_log format ["%1 [%2] Fireing on target %3", _unit, typeof _unit, _randomTarget];
    
        if (_doSuppressiveFire) then {
            //gunner _unit doSuppressiveFire _randomTarget;
            if (typeOf _unit isKindOf "RHS_ZU23_base") then {
                for "_i" from 0 to 40 do {
                    gunner _unit forceWeaponFire [currentWeapon (vehicle _unit), _firemode];
                    sleep 0.1;
                };
            } else {
                gunner _unit forceWeaponFire [currentWeapon (vehicle _unit), _firemode];
            };
        } else {
            gunner _unit forceWeaponFire [currentWeapon (vehicle _unit), _firemode];
        };
        
        _unit setAmmo [currentWeapon (vehicle _unit), 500];
        
        sleep random [2,3,4];
    };
} else {

    private _firemodes = (getArray (configFile >> "CfgWeapons" >> currentWeapon _unit >> "modes"));
    if (!(_firemode in _firemodes)) then {
        diag_log format ["WARNING: Firemode not in %1 [%2] firemode list %3.", _unit, typeof _unit, _firemodes];
        _firemode = _firemodes#0;
        diag_log format ["WARNING: Trying to owerwrite %1 [%2] firemode with %1", _unit, typeof _unit, _firemode];
    };
    
    diag_log format ["%1 [%2] is man", _unit, typeof _unit];
    while {alive _unit || _targetlist isEqualTo []} do {
        private _randomTarget = selectRandom _targetlist;
        diag_log format ["%1 [%2] Aquiring target %3", _unit, typeof _unit, _randomTarget];
        _unit doTarget _randomTarget;
    
        waitUntil { sleep random [2,2.5,3]; true };
        diag_log format ["%1 [%2] Fireing on target %3", _unit, typeof _unit, _randomTarget];
    
        _unit forceWeaponFire [currentWeapon (vehicle _unit), _firemode];
        
        _unit setAmmo [currentWeapon (vehicle _unit), 500];
        
        sleep random [2,3,4];
    };
};