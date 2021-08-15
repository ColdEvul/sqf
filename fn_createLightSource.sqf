/*
 * Author: CPL.Brostrom.A
 * This function creates a lightsoruce from a given object.
 * Run this function in the object or unit init (recommend to use the texture object).
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Brightness <NUMBER>
 *
 * Example:
 * [this] execVM "scripts\fn_createLightSource.sqf";
 * [this, 1.5] execVM "scripts\fn_createLightSource.sqf";
 *
 */

params [
    ["_object", objNull, [objNull]],
    ["_brightness", 1.5, [1.5]]
];

private _lightpoint = "#lightpoint" createVehicleLocal (getPos _object); 
_lightpoint setLightColor [0,0,0]; 
_lightpoint setLightAmbient [0.8,0.8,0.8]; 
_lightpoint setLightBrightness _brightness;