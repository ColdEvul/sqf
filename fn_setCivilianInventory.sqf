/*
 * Author: CPL.Brostrom.A
 * This function adjustes a given units inventory. Usefull for civilian units.
 * Run this function in the unit init.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Example:
 * this execVM "scripts\fn_setCivilianInventory.sqf"
 *
 */

params ["_object"];

_object unassignItem "ItemMap";
_object removeItem "ItemMap";
_object unassignItem "ItemCompass";
_object removeItem "ItemCompass";


private _watch = selectRandom ["ItemWatch", "", ""];
if (_watch == "") then {
    _object unassignItem "ItemWatch";
    _object removeItem "ItemWatch";
};

private _money = selectRandom ["Money_roll", "Money_bunch", "Money_bunch", "Money_bunch", "Money_bunch", "", ""];
if (_money != "") then {
    [_object, _money] call CBA_fnc_addItem;
};

private _wallet = selectRandom ["Wallet_ID", "Wallet_ID", ""];
if (_wallet != "") then {
    [_object, _wallet] call CBA_fnc_addItem;
};

private _phone = selectRandom ["MobilePhone", "MobilePhone", "MobilePhone", "SmartPhone", "", "", "", ""];
if (_phone != "") then {
    [_object, _phone] call CBA_fnc_addItem;
};
