`timescale 1ns / 1ps

module Subtractor_8bits_tb();
reg [7:0] A_tb, B_tb;
wire [7:0] S_tb;

Subtractor_8bits Subtractor_8bits_tb (A_tb, B_tb, S_tb);

initial
begin
A_tb <= 100;
B_tb <= 50;
end
endmodule
