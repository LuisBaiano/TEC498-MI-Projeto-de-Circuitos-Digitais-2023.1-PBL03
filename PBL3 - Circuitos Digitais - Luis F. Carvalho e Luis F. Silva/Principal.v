module Principal(

    input clk, Cancel, 
    input [2:0]chaves_sensores, 
	 input [2:0]chaves_cedulas,
    input [3:0]botoes, 
	 output [3:0]digitos,
    output [9:0]leds,
	 output LED_Verm, LED_Verde, LED_Azul,
    output [6:0]segmentos,
	 output ponto

);
    or(ponto, 1'b1); //desliga os pontos
    wire clk0, clk1, clk2, clk3; //fios para as saídas do Divisor de Clock
    wire [1:0]Estado_atual; //pega qual o estado que deve ser processado
    wire V_sense, Valor_verificado, Devolver_dinheiro; //variáveis para transição entre os estados

    wire Temp_2, Temp_2_1, Temp_5, Temp_15; //fios de saída dos temporizadores 
    wire reset_Temp_2,reset_Temp_2_1, reset_Temp_5, reset_Temp_15; //reset dos temporizadores

    Divisor_Clock(clk, clk0, clk1, clk2, clk3);

    temp_2_seg(clk3, reset_Temp_2, Temp_2); // Temporizador da pressurização da bebida
    temp_2_seg(clk3, Temp_2, Temp_2_1); // Temporizador do aquecimento da água da bebida
    temp_5_seg(clk3, Temp_2_1, Temp_5); // Temporizador do dispenser de bebida
    temp_15_seg(clk3, reset_Temp_15, Temp_15);//Temporizador para resetar o estado de venda


    Sensores(chaves_sensores, V_sense, leds[7], leds[8], leds[9]); //Verifica os estados dos sensores

	 Controla_Display(clk0, clk3, Cancel, V_sense, chaves_cedulas, botoes, digitos, segmentos, Valor_verificado, LED_Verm, LED_Verde, LED_Azul);

    Estados(clk3, Cancel, Valor_verificado, V_sense, Temp_2, Temp_2_1, Temp_5, Temp_15, led_press, led_aquec, led_bebida_1, led_bebida_2, reset_Temp_2, reset_Temp_15, Devolver_dinheiro);


endmodule
