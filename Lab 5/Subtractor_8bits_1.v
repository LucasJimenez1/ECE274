`timescale 1ns / 1ps

// 8-bit subtractor
// S = A - B
module Subtractor_8bits(A,B,S);

    input [7:0] A,B;
    output [7:0] S;

    assign S = A - B;

endmodule
