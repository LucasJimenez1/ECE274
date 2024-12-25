`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: R. Thamvichai
// 
// Create Date: 08/24/2020
// Design Name: 
// Module Name: TwoDigitDisplay
//////////////////////////////////////////////////////////////////////////////////
module TwoDigitDisplay(CLK100MHZ, SW, CA,CB,CC,CD,CE,CF,CG,AN);
    input  CLK100MHZ;
    input  [6:0] SW;
    output CA,CB,CC,CD,CE,CF,CG; //each segment of a 7-seven display
    output reg [7:0] AN; //to enable each digit from left to right of the 8 digits on the board
                         //bit AN[7] is used for the leftmost digit,
                         //bit AN[0] is used for the rightmost digit
             
    reg  [3:0] in4;        
    reg  [3:0] firstdigit;
    reg  [3:0] seconddigit;
    
    //--------- --------- --------- --------- //
    //-- to use the module SevenSegment 
   SevenSegment a1(in4,CA,CB,CC,CD,CE,CF,CG);
    //--------- --------- --------- --------- //
         
    //-- divider counter for ~95.3Hz refresh rate (with 100MHz main clock)
    reg  [19:0] cnt;
    always @(posedge CLK100MHZ) begin
        cnt <= cnt + 1;
    end
    
    //-- to seperate each decimal digit for display
    always @(SW) begin
            if (SW < 100)
                begin
                    firstdigit <= SW%10;
                    seconddigit <= SW/10;
                end 
             else
             begin
                    firstdigit <= 4'b1111;
                    seconddigit <= 4'b1111;
             end
    end
    
    //-- to display the number in the appropriate 7-segment digit
    always @(cnt) begin
        case(cnt[19:17])  //100MHz/(2^20) = 95.3 Hz
            3'b000: begin AN <= 8'b11111110; in4 <= firstdigit; end
            3'b001: begin AN <= 8'b11111101; in4 <= seconddigit; end
            //can be used if need to display more than 2 digits
            //3'b010: begin AN <= 8'b11111011;
            //3'b011: begin AN <= 8'b11110111;
            //3'b100: begin AN <= 8'b11101111;
            //3'b101: begin AN <= 8'b11011111;
            //3'b110: begin AN <= 8'b10111111;
            //3'b111: begin AN <= 8'b01111111;
            default: begin AN <= 8'b11111111; in4 <= 4'b1111; end 
        endcase
     end
     
     
    
endmodule
