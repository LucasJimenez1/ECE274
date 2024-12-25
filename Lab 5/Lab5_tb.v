`timescale 1ns / 1ps


module Lab5_tb();
    reg Clk, Rst, go;
    wire [11:0] sum;
    wire done;
    
    
    Lab5 a1(Clk, Rst, go, sum, done);
    
    always 
    begin
        Clk <= 0;
        #100;
        Clk <= 1;
        #100;
    end
    
    initial
    begin
        Rst <= 1'b1; go <= 0;
        @ (posedge Clk);
        #50 Rst <= 1'b0; 
        @ (posedge Clk);
        @ (posedge Clk);
        #50 go <= 1;
        @ (posedge Clk);
        #50 go <= 0;
    end
endmodule
