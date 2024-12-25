`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2023 03:58:42 PM
// Design Name: 
// Module Name: TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TB();
    //inputs
    reg Rst, Clk, go;
    
    //outputs
    wire done;
    wire [7:0] sum;
    wire [7:0] average;
    wire [3:0] countodd;
    
    Exam3 tb(.Rst(Rst),.Clk(Clk),.go(go),.done(done),.sum(sum),.average(average),.countodd(countodd));
    
    //Clock gen
    always begin
    Clk <= ~Clk;
    #100;
    end
    
    initial begin
    Clk <= 0;
    Rst <= 1;
    go <= 0;
    
    @(posedge Clk);
    #50
    
    Rst <= 0;
    go <= 0;
    
    @(posedge Clk);
    go <= 1;
    @(posedge Clk);
    #50
    go <= 0;
    @(posedge Clk);
    
    end    
endmodule
