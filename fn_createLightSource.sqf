// [this] execVM "scripts\fn_createLightSource.sqf";
// [this,1.5] execVM "scripts\fn_createLightSource.sqf";
params [
    ["_object", objNull, [objNull]],
    ["_brightness", 1.5, [1.5]]
];

_lightpoint = "#lightpoint" createVehicleLocal (getPos _object); 
_lightpoint setLightColor [0,0,0]; 
_lightpoint setLightAmbient [0.8,0.8,0.8]; 
_lightpoint setLightBrightness _brightness;