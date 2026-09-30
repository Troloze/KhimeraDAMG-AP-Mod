var extension = argument0;
var value = argument1;

var pattern = "*." + extension;
var new_name = string_format(value, 0, 0) + "." + extension;

var entry = file_find_first(pattern, 0);
if (entry == "") {
    file_text_close(file_text_open_write(new_name));
    file_find_close();
    return;
}
var new_entry = file_find_next(); 
while (new_entry != "") {
    file_delete(new_entry);
    new_entry = file_find_next();
}
file_find_close();

if (entry == new_name) return;
file_rename(entry, new_name);