`timescale 1ns / 1ps

//8-bit 2x1 multiplexor
//if s = 1, D = I1
//else, D = I0

module mux(s, I1, I0, D);
    input [7:0] I1, I0;
    input s;
    output reg [7:0] D;
    
    //write your code here
    
    always @(s, I1,I0) begin
    
    if (s) begin
    
    D = I1;
    end
    
    else if (~s)
    begin D = I0;
    end
    
    end

endmodule
