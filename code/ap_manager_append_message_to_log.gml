if (is_undefined(current_message)) return;

var c_t = current_message[message_field];

if (string_length(c_t) > text_length_hard_cap) c_t  = string_copy(c_t , 1, text_length_hard_cap);
c_t = string_upper(c_t);
c_t = string_replace_all(c_t, "#", "\\#");
c_t =  ap_misc_cut_text(text_line_width, text_max_lines, text_line_sep, text_font, c_t);
if (c_t == "") return;
current_message[message_field] = c_t;

var i;
text_last_index = text_current_messages++ % text_message_cap
for (i = 0; i < text_fields; i++) {
    ds_grid_set(text_log, i, text_last_index, current_message[i]);
}

current_message = undefined;