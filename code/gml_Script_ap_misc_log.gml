var message = argument0;

if (! directory_exists("logs")) {
    directory_create("logs");
}

var log_file = "logs/" + global.ap_startup_time_stamp + ".txt";

if (! file_exists(log_file)) {
    // Header.
    var _file = file_text_open_append(log_file);
    file_text_write_string(_file, "Khimera: Destroy All Monster Girls - Archipelago Randomizer " + global.ap_mod_version);
    file_text_writeln(_file);
    file_text_close(_file);
}

var log = "[" + ap_misc_generate_time_stamp(true) + "]: "+ message

var file = file_text_open_append(log_file);
file_text_write_string(file, log);
file_text_writeln(file)
file_text_close(file)
