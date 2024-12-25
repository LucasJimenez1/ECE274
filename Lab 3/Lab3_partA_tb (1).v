`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: 
// 
// Create Date: 09/25/2023 10:00:48 AM
// Design Name: 
// Module Name: Lab3_partA_tb
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


module Lab3_partA_tb();

    reg Clk_tb, Rst_tb, L_tb, R_tb; //inputs
    wire CA_tb, CB_tb, CF_tb, CG_tb; //outputs
    integer i; //loop integer

    // Instantiate the FSM
    //Maybe fix if sim doesnt work (31-40 lines)
    
    Lab3_partA uut (
        .Clk(Clk_tb),
        .Rst(Rst_tb),
        .L(L_tb),
        .R(R_tb),
        .CA(CA_tb),
        .CB(CB_tb),
        .CF(CF_tb),
        .CG(CG_tb)
    );

    // Clock generation
    always begin
        #5 Clk_tb = ~Clk_tb;
    end

    // Test scenarios
    initial begin
        // Initial conditions
        Clk_tb = 0;
        Rst_tb = 0;
        L_tb = 0;
        R_tb = 0;

        // Activate reset
        #100 Rst_tb = 1;
        #100 Rst_tb = 0;
        #100;

        // Scenario 1: R=0, L=0 (all lights are off)
        L_tb = 0;
        R_tb = 0;
        #100;

        // Scenario 2: L=1, R=0 for 6 clock cycles
        L_tb = 1;
        R_tb = 0;
        for (i = 0; i < 6; i = i + 1) begin
            @(posedge Clk_tb);
        end

        // Scenario 3: L=0, R=1 (clockwise circle sequence) for 6 clock cycles
        L_tb = 0;
        R_tb = 1;
        for (i = 0; i < 6; i = i + 1) begin
            @(posedge Clk_tb);
        end

        // Scenario 4: L=1, R=1 (all segments ON and OFF sequence) for 6 clock cycles
        L_tb= 1;
        R_tb= 1;
        for (i = 0; i < 6; i = i + 1) begin
            @(posedge Clk_tb);
        end

        // Scenario 5: User changes input in the middle of a sequence
        L_tb= 1;
        R_tb= 1;
        for (i = 0; i < 6; i = i + 1) begin
            @(posedge Clk_tb);
            begin
            if (i == 3)
            R_tb = 0;
            end
            
        end
        $finish;
    end

    // Monitor the outputs
    initial begin
        $monitor($time, " CA=%b CB=%b CF=%b CG=%b", CA_tb, CB_tb, CF_tb, CG_tb);
    end
endmodule