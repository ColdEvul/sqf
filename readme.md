# SQF Scripts
Profile script means that the object is removed and recreated based on proximity. 

## Script snippets
Here are some quick script snippets 

#### Heal player
```js
// Local or Global execute
if (isServer) exitWith {};
[player, player] call ace_medical_treatment_fnc_fullHeal;
```

#### Earplugs in player
```js
// Local or Global execute
if (isServer) exitWith {};
[player] call ace_hearing_fnc_putInEarplugs;
```

#### Add radio to player inventory
```js
// Local or Global execute
if (isServer) exitWith {};
[player, "ACRE_PRC343"] call CBA_fnc_addItem;
[player, "ACRE_PRC152"] call CBA_fnc_addItem;
```

#### CBA Settings - Clear all settings
```js
// Server execute
['server'] call CBA_settings_fnc_clear;
```

#### cScripts - Set a Loadout

```js
// Target Client, Local or Global execute
if (isServer) exitWith {};
[player, "Cav_B_C_Rifleman_F"] call cScripts_fnc_gear_applyLoadout;
```
```js 
// Target Client, Local or Global execute
if (isServer) exitWith {};
[player, "Cav_B_B_Scout_Rifleman_F"] call cScripts_fnc_gear_applyLoadout;
```
```js
// Target Client, Local or Global execute
if (isServer) exitWith {};
[player, [[],[],[],[],[],[],"","",[],["","","","","",""]]] call cScripts_fnc_gear_applyLoadout;
```
