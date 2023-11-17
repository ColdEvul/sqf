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
 *
 */
 params [
    ["_unit", objNull, [objNull]],
    ["_assignedTargets", [], [[]]],
    ["_firemode", "Single", [""]]
];

waitUntil { sleep random [4, 5, 6]; true };

private _allTargetItems = allMissionObjects "UserTexture1m_F";
private _targetlist = _unit getVariable ["ai_fire_target_list", _assignedTargets];

if (_targetlist isEqualTo []) then {
    private _targetObjectList = [];
    {
        private _target = [_x] call BIS_fnc_objectVar;
        _target = [_target, 0, 13] call BIS_fnc_trimString;
        _target = toLower _target;
        if (_target == "ai_fire_target") then {
            //diag_log format ["%1 found target %1", _target];
            _targetObjectList append [_x];
        };
    } forEach _allTargetItems;
    _unit setVariable ["ai_fire_target_list", _targetObjectList];
};

_targetlist = _unit getVariable ["ai_fire_target_list", []];

if (_targetlist isEqualTo []) exitWith {
    diag_log format ["ERROR: No targets available for %1", _unit];
};


while {alive _unit || _targetlist isEqualTo []} do {
    private _randomTarget = selectRandom _targetlist;
    //diag_log format ["Aquiring target %1", _randomTarget];
    _unit doTarget _randomTarget;

    waitUntil { sleep random [2,2.5,3]; true };
    //diag_log format ["Fireing on target %1", _randomTarget];

    _unit forceWeaponFire [currentWeapon (vehicle _unit), _firemode];
    
    _unit setAmmo [currentWeapon (vehicle _unit), 15];
    
    sleep random [2,3,4];
};
