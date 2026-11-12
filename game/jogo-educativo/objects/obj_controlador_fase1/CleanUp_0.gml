
/// obj_controlador_frase1 - CLEAN UP
/// Libera a fonte carregada dinamicamente.

if (fonte_palavras != -1) {

    if (font_exists(fonte_palavras)) {
        font_delete(fonte_palavras);
    }
}
