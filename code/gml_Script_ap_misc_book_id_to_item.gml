var book_id = argument0

if (book_id < 0 || book_id > 38) return undefined;

return ap_item_make(global.AP_ITEM_BOOK, book_id);