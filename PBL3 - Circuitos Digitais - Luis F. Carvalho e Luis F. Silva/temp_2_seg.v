module temp_2_seg(clk, reset, Temp_2);

	input clk, reset; // Portas de entrada: clk (clock) e reset (sinal de reset)
	output reg Temp_2; // Porta de saída: Temp_2 (sinal de saída)
	reg [1:0] cont; // Registrador de 2 bits para controlar o estado do contador

	initial begin
		Temp_2 <= 1'b0; // Inicializa o sinal de saída Temp_2 com 0
	end
	
	always @(posedge reset, posedge clk) begin // Sempre que ocorrer uma borda de subida em reset ou clk
		if (reset) begin // Se o sinal de reset estiver ativo
			cont = 2'b0; // Reseta o contador para 0
			Temp_2 <= 1'b0; // Define o sinal de saída Temp_2 como 0
		end
		else begin // Caso contrário
			if (cont == 2'b1) begin // Se o contador estiver no estado final (3)
				cont = 2'b0; // Reseta o contador para 0
				Temp_2 <= 1'b1; // Define o sinal de saída Temp_2 como 1
			end
			else begin // Caso contrário
				cont = cont + 1'b1; // Incrementa o contador
				Temp_2 <= 1'b0; // Define o sinal de saída T2 como 0
			end
		end
	end
endmodule
