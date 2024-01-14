/*
 * Author: CPL.Brostrom.A
 * This function replace a weapon and removes the ability to pick it up.
 * You can also specifie a config variant of a weapon.
 * Run this function in the object init.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Classname <STRING> (Optional)
 *
 * Example:
 * [this] execVM "scripts\fn_replaceDisplayItem.sqf";
 * [this, ""] execVM "scripts\fn_replaceDisplayItem.sqf";
 * [this, "rhs_m4_compm4"] execVM "scripts\fn_replaceDisplayItem.sqf";
 * [this, "rhs_weap_m16a4_grip_acog"] execVM "scripts\fn_replaceDisplayItem.sqf";
 *
 */

params [
    ["_carrier", objNull, [objNull]],
    ["_newDisplay", "", [""]]
];

if !(isServer) exitWith {};

_carrier enableSimulationGlobal false;

if (_newDisplay isKindOf ["CA_Magazine", configFile >> "CfgMagazines"]) then {
    clearMagazineCargoGlobal _carrier;
    _carrier addMagazineCargoGlobal [_newDisplay, 1];
};
if (_newDisplay isKindOf ["RifleCore", configFile >> "CfgWeapons"]) then {
    clearWeaponCargoGlobal _carrier;
    _carrier addWeaponCargoGlobal [_newDisplay, 1];
};

_carrier setdamage 1;
