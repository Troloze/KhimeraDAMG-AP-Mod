var color1 = argument0;
var color2 = argument1;
var rate = argument2;

if (rate > 1) return color2;
if (rate < 0) return color1;

var red1 = color_get_red(color1);
var red2 = color_get_red(color2);
var green1 = color_get_green(color1);
var green2 = color_get_green(color2);
var blue1 = color_get_blue(color1);
var blue2 = color_get_blue(color2);

return make_color_rgb(
    (red2 - red1) * rate + red1,
    (green2 - green1) * rate + green1,
    (blue2 - blue1) * rate + blue1
);