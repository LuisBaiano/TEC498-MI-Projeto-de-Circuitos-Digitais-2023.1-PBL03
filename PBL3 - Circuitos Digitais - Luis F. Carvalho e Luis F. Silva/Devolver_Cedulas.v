module Devolver_Cedulas(
  input Devolver_dinheiro,  // Entradas para  Devolver_dinheiro
  output Led_2, Led_3                                // Saídas para Led_2 e Led_3
);
  wire Devolver_Cedulas;                             // Fio (wire) para o sinal Devolver_Cedulas

  // Realiza a operação lógica OR
  or(Devolver_Cedulas, Devolver_dinheiro);

  // Atribui o valor do sinal Devolver_Cedulas para as saídas Led_2 e Led_3
  assign Led_2 = Devolver_Cedulas;
  assign Led_3 = Devolver_Cedulas;

endmodule
