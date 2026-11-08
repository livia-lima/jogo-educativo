slider_aberto = !slider_aberto; // Inverte entre aberto e fechado

if (slider_aberto) {
    // Nasce o slider e puxa ele para a frente (ajuste o x + 30 conforme precisar)
    meu_slider = instance_create_layer(x + 30, y - 2, layer, obj_slider_som); 
    meu_slider.depth = depth - 1; 
} else {
    // Se estava aberto e clicou de novo, apaga o slider da tela
    if (instance_exists(meu_slider)) {
        instance_destroy(meu_slider);
    }
}