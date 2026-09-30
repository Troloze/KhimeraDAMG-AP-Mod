var file_name = argument0;

// Will explode if file_name isn't a string, which it always should be. 
// Therefore, I'd rather have it explode so I can detect it than handle the error.
var rd_name = file_name + ".rd";

// Handshake
if (!file_exists(file_name)) return -1;
if (file_exists(rd_name)) {
    file_delete(rd_name);
    if (file_exists(rd_name)) return -1;
}
file_rename(file_name, rd_name);
if (!file_exists(rd_name)) return -1; // Could not rename.

// Reading the file and cleaning up
var file = file_text_open_read(rd_name);
if (file == -1) return -1;
var raw = file_text_read_string(file);
file_text_close(file);
// The client should send the game another one with all the relevant information (items, locations, etc; not messages)
// even if this one fails, so it is ok to delete here.
file_delete(rd_name);

// Decoding the JSON
var json = json_decode(raw);
if (json == -1) return -1; // Malformed
if (!ds_map_exists(json, "message")) {
    ds_map_destroy(json); // Malformed
    return -1;
}

return json;