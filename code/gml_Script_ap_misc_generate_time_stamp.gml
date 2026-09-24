var extended = argument0

var year = string(current_year);
var month = string(current_month);
var day = string(current_day);
var hour = string(current_hour);
var minute = string(current_minute);
var second = string(current_second);

month = string_repeat("0", 2 - string_length(month)) + month;
day = string_repeat("0", 2 - string_length(day)) + day;
hour = string_repeat("0", 2 - string_length(hour)) + hour;
minute = string_repeat("0", 2 - string_length(minute)) + minute;
second = string_repeat("0", 2 - string_length(second)) + second;

if (extended) return year + "-" + month + "-" + day + " " + hour + "-" + minute + "-" + second
else return hour + "-" + minute + "-" + second 