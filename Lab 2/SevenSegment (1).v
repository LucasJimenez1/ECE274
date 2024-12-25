`timescale 1ns / 1ps
module SevenSegment(SW,CA,CB,CC,CD,CE,CF,CG);
// 4-bit input using switches 3 - 0
input [3:0] SW;
//each segment of seven-segment display
output reg CA, CB, CC, CD, CE, CF, CG;
//write your code using case statement here
always @ (SW)
begin
    case (SW)
    4'b0000: {CA, CB, CC, CD, CE, CF, CG} = 7'b0000001; // 0
    4'b0001: {CA, CB, CC, CD, CE, CF, CG} = 7'b1001111; // 1
    4'b0010: {CA, CB, CC, CD, CE, CF, CG} = 7'b0010010; // 2
    4'b0011: {CA, CB, CC, CD, CE, CF, CG} = 7'b0000110; // 3
    4'b0100: {CA, CB, CC, CD, CE, CF, CG} = 7'b1001100; // 4
    4'b0101: {CA, CB, CC, CD, CE, CF, CG} = 7'b0100100; // 5
    4'b0110: {CA, CB, CC, CD, CE, CF, CG} = 7'b0100000; // 6
    4'b0111: {CA, CB, CC, CD, CE, CF, CG} = 7'b0001111; // 7
    4'b1000: {CA, CB, CC, CD, CE, CF, CG} = 7'b0000000; // 8
    4'b1001: {CA, CB, CC, CD, CE, CF, CG} = 7'b0000100; // 9
    default: {CA, CB, CC, CD, CE, CF, CG} = 7'b1111111; // all lights off (default)
    endcase
 end


endmodule