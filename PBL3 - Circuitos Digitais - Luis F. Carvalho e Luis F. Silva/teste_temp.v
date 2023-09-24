/*module teste_temp(
    input clk,
    output led_2seg, led_2_1seg, led_5seg, led_15seg
);

    wire clk0, clk1, clk2, clk3;

    wire Temp_2, Temp_2_1, Temp_5, Temp_15; //fios de saída dos temporizadores 
    wire reset_T2, reset_T2_1, reset_T5, reset_Temp_15; //reset dos temporizadores

    Divisor_Clock(clk, clk0, clk1, clk2, clk3);

    temp_2_seg(clk3, reset_T2, Temp_2);    // Temporizador da pressurização da bebida
    temp_2_seg(clk3, Temp_2, Temp_2_1);   // Temporizador do aquecimento da água da bebida
    temp_5_seg(clk3, Temp_2_1, Temp_5);   // Temporizador do dispenser de bebida
    temp_15_seg(clk3, reset_Temp_15, Temp_15); // Temporizador para resetar o estado de venda

	assign led_2seg = Temp_2;
	assign led_2_1seg = Temp_2_1;
	assign led_5seg = Temp_5;
	assign led_15seg = Temp_15;


endmodule*/
