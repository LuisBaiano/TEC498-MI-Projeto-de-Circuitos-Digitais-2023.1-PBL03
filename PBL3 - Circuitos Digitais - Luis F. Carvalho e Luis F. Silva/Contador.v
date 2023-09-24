module Contador(
	input out1,
	output reg [2:0] select
);

		//Contador de tres bits utilizado como chave de seleçao para  amultiplexaçao do Display de sete segmentos
		//Utiliza clock de 48 KHz
		
	always @(posedge out1) begin
    select <= select + 1'b1;
    if (select == 3'b111) begin
      select <= 3'b000;
    end
  end
endmodule
