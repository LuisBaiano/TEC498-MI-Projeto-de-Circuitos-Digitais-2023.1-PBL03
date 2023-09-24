module temp_5_seg(clk, reset, Temp_5);

	input clk, reset; // Portas de entrada: clk (clock) e reset (sinal de reset)
	output reg Temp_5; // Porta de saída: Temp_5 (sinal de saída)
	reg [2:0] cont; // Registrador de 3 bits para contar os segundos (2^3 = 8 ciclos de clock)

	initial begin
		Temp_5 <= 1'b0; // Inicializa o sinal de saída Temp_5 com 0
	end

	always @(posedge reset, posedge clk) begin // Sempre que ocorrer uma borda de subida em reset ou clk
		if (reset) begin // Se o sinal de reset estiver ativo
			cont <= 3'b0; // Reseta o contador para 0
			Temp_5 <= 1'b0; // Define o sinal de saída Temp_5 como 0
		end
		else begin // Caso contrário
			if (cont == 3'd4) begin // Se o contador alcançar 5 segundos (4 ciclos de clock)
				cont <= 3'b0; // Reseta o contador para 0
				Temp_5 <= 1'b1; // Define o sinal de saída Temp_5 como 1
			end
			else begin // Caso contrário
				cont <= cont + 1'b1; // Incrementa o contador
				Temp_5 <= 1'b0; // Define o sinal de saída Temp_5 como 0
			end
		end
	end

endmodule
