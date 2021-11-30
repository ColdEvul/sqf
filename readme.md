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

#### CBA Settings - Clear all settings
```js
// Server execute
['server'] call CBA_settings_fnc_clear;
```
