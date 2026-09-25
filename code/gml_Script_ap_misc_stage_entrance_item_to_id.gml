var item = argument0;

if (floor(item/100000) != 5001) return undefined;
return (item%100000) - 1;
