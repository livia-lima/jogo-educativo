slider_aberto = !slider_aberto;
if (slider_aberto) {
    meu_slider = instance_create_layer(x - 150, y, layer, obj_slider_fonte); // Ajuste o -150 para encaixar na arte
    meu_slider.depth = depth - 1; 
} else {
    if (instance_exists(meu_slider)) instance_destroy(meu_slider);
}