// Cleanup time!
var cleanup = ds_list_create();
ds_list_add(cleanup, "ap.cctx.rd", "ap.li.rd", "ap.hi.rd", "ap.gi", "ap.gi.tmp", "*.gshb", "*.gsreq", "*.gsack", "*.gswin");
var cl_size = ds_list_size(cleanup);
var i;

for (i = 0; i < cl_size; i++) {
    // Navigate through each pattern
    var c_file = file_find_first(ds_list_find_value(cleanup, i), 0);
    while (c_file != "") {
        file_delete(c_file);
        c_file = file_find_next();
    }
    file_find_close();
}

ds_list_destroy(cleanup) // Cleanup's cleanup cleanup.