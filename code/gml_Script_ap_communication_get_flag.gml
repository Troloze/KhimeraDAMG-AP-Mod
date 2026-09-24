var extension = argument0;

var pattern = "*." + extension;
var entry = file_find_first(pattern, 0);
if (entry == "" || file_find_next() != "") {
    // No file or more than one file.
    file_find_close();
    return undefined;
}
file_find_close();

var en_size = string_length(entry);
var ex_size = string_length(extension);

var value = string_copy(entry, 1, en_size - ex_size - 1);

return value