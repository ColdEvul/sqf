/*
 * Author: CPL.Brostrom.A
 * This function allow you to change state on a flag pole.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Starting Side <NUMBER> [Default; 3] (Optional)
 *
 * Return:
 * True or False on success
 *
 * Example:
 * [this] execVM "scripts\fn_capturableFlag.sqf";
 * [this, 3] execVM "scripts\fn_capturableFlag.sqf";
 */

params [
    ["_object", objNull, [objNull]],
    ["_startingSide", 3, [3]]
];

if (isNull _object) exitWith { diag_log "Error: No object defined"; false; };

// Functions
fn_getFlagTexture ={
    params ["_side"];
    private _return = switch (_side) do
    {
        case 0: {"\rhsafrf\addons\rhs_main\data\flag_map\Flag_rus_CO.paa"};  // "\A3\Data_F\Flags\flag_red_CO.paa"
        case 1: {"\rhsusf\addons\rhsusf_main\data\flag_map\flag_us_co.paa"}; //	"\A3\Data_F\Flags\flag_blue_CO.paa"
        case 2: {"\A3\Data_F\Flags\flag_green_CO.paa"};                      // "\A3\Data_F\Flags\flag_green_CO.paa"
        case 3;
        default {"\A3\Data_F\Flags\flag_white_CO.paa"};
    };
    _return;
};

fn_setFlagOwner = {
    params ["_object", "_side"];
    _object setVariable ["flagPoleSideOwner", _side];
    private _flag = _side call fn_getFlagTexture;
    _object setFlagTexture _flag;
};



// Init
[_object, _startingSide] call fn_setFlagOwner;



// Actions
private _fn_codeProgress = {
    params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
};

private _fn_codeCompleted = {
    params ["_target", "_caller", "_actionId", "_arguments"];
    private _playerSide = [side _caller] call BIS_fnc_sideID;
    [_target, _playerSide] call fn_setFlagOwner;
};

[
    _object,
    "Capture flag",
    "", "",
    "_this distance _target < 3",
    "_caller distance _target < 3",
    {},
    _fn_codeProgress,
    _fn_codeCompleted,
    {},
    [],
    10,
    nil,
    false,
    false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _object];

true
