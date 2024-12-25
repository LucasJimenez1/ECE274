`timescale 1ns / 1ps
module SevenSegment_tb( );
reg [3:0] SW_tb; //a vector signal is also used in the testbench
wire CA_tb, CB_tb, CC_tb, CD_tb, CE_tb, CF_tb, CG_tb;
SevenSegment SevenSegment_tb(SW_tb,CA_tb, CB_tb, CC_tb, CD_tb, CE_tb, CF_tb, CG_tb);
initial
begin

//case 0
SW_tb = 4'b0000; //b is for binary and 4 is for 4-bit
#100;
SW_tb = 4'b0001; //case 1
#100;
SW_tb = 4'b0010; // case 2
#100
SW_tb = 4'b0011; // case 3
#100
SW_tb = 4'b0100; // case 4
#100
SW_tb = 4'b0101; // case 5
#100
SW_tb = 4'b0110; // case 6
#100
SW_tb = 4'b0111; // case 7
#100
SW_tb = 4'b1000; // case 8
#100
SW_tb = 4'b1001; // case 9


// use this idea for other combinations (all combinations of inputs)
end

endmodule
