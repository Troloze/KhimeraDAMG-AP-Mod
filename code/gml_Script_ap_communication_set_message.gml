var file_name = argument0;
var value = argument1;

var tmp_name = file_name + ".tmp";

var encoded_string = json_encode(value);

if (file_exists(file_name)) file_delete(file_name); // We should not get here, user should always probe before writing.

var f = file_text_open_write(tmp_name);
file_text_write_string(f, encoded_string);
file_text_close(f)

file_rename(tmp_name, file_name);

if (file_exists(file_name)) return true;
return false;