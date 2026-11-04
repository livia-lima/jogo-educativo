if (numero == 0 && point_distance(mouse_x, mouse_y, x, y) < 60) {
    obj_fase2_controle.contagem++;
    numero = obj_fase2_controle.contagem;
    escala = 1.3;
    obj_fase2_controle.tocar_som("snd_numero_" + string(numero));
}
escala = lerp(escala, 1, 0.1);