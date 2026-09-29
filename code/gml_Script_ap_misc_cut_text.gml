var width = argument0;
var line_count = argument1;
var sep = argument2;
var font = argument3;
var message = argument4;

draw_set_font(font);

var test_char = "M";
var m_h = test_char, i;
var line_height = string_height(m_h);
for (i = 1; i < line_count; i++) {m_h += "#" + test_char;}

var max_height = string_height_ext(m_h, sep, width);

var c_height = string_height_ext(message, sep, width);

if (c_height <= max_height) return message;

var char_count = string_length(message);

var p1 = 1, p2 = char_count, pm, c_str;

while (p1 + 1 < p2) {
    pm = floor((p1 + p2)/2);
    c_str = string_copy(message, 1, pm) + "...";
    c_height = string_height_ext(c_str, sep, width);
    if (c_height > max_height) {
        p2 = pm;
    } else {
        p1 = pm;
    }
}

c_str = string_copy(message, 1, p1) + "...";
c_height = string_height_ext(c_str, sep, width);

if (c_height > max_height) {
    while (c_height > max_height && p1 > 0) {
        p1--;
        c_str = string_copy(message, 1, p1) + "...";
        c_height = string_height_ext(c_str, sep, width);
    }
}

if (c_height > max_height) return "";
else return c_str; 