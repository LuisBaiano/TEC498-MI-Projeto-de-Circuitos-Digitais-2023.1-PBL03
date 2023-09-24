module temp_15_seg(clk, reset, Temp_15);
	input clk, reset; // Portas de entrada: clk (clock) e reset (sinal de reset)
	output reg Temp_15; // Porta de saída: Temp_15 (sinal de saída)

	reg [3:0] cont; // Registrador de 4 bits para controlar o estado do contador

	initial begin
		Temp_15 <= 1'b0; // Inicializa o sinal de saída Temp_15 com 0
	end

	always @(posedge reset, posedge clk) begin // Sempre que ocorrer uma borda de subida em reset ou clk
		
		if (reset) begin // Se o sinal de reset estiver ativo
			cont = 4'b0; // Reseta o contador para 0
			Temp_15 <= 1'b0; // Define o sinal de saída Temp_15 como 0
		end
		
		else begin // Caso contrário
			
			if (cont == 4'b1110) begin // Se o contador estiver no estado final (14)
				cont = 4'b0; // Reseta o contador para 0
				Temp_15 <= 1'b1; // Define o sinal de saída Temp_15 como 1
			end
			
			else begin // Caso contrário
				cont = cont + 1'b1; // Incrementa o contador
				Temp_15 <= 1'b0; // Define o sinal de saída Temp_15 como 0
			end
		end
	end
endmodule
