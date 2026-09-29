var item = argument0;

if (floor((item - global.AP_ID_ITEM)/global.AP_ID_TYPE) != global.AP_ITEM_STAGE) return undefined;
return (item%global.AP_ID_TYPE) - 1;
