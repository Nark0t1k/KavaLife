#include "..\..\script_macros.hpp"
/*
fn_callCellPhone.sqf
*/

if(!("ItemRadio" in (assignedItems player))) exitWith{hint parseText "Vous n'avez pas de telephone (Radio).";};

createDialog "Life_KPhoneMenu";