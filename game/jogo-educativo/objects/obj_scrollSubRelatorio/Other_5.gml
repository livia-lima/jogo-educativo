if (_FILE != -1){
	file_text_close(_FILE)
}
if (ds_exists(menu,ds_type_grid)) ds_grid_destroy(menu)