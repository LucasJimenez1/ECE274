`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: 
// 
// Create Date: 09/25/2023 09:22:46 AM
// Design Name: 
// Module Name: Lab3_partA
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
module Lab3_partA(
    input Clk,
    input Rst,
    input L,
    input R,
    output reg CA,
    output reg CB,
    output reg CF,
    output reg CG
);

    // Define the states using local parameters
    localparam OFF_STATE = 3'b000; //when off
    localparam ALL_ON_STATE = 3'b001; //when on
    localparam A_ON = 3'b010; //A on
    localparam A_F_ON = 3'b011; //A & F on
    localparam A_F_G_ON = 3'b100; // A & F & G on
    localparam A_F_G_B_ON = 3'b101; //A & F & G & B on
    localparam A_B_ON = 3'b110; //B on 
    localparam A_B_G_ON = 3'b111; // G on

    reg [2:0] state, next_state;
    
    
//Begin with off state if Rest or move on to next stae
    always @(posedge Clk or posedge Rst) begin
        if (Rst)
            state <= OFF_STATE;
        else
            state <= next_state;
    end

    // Defining different state logics
    always @(*) begin
        case (state)
            OFF_STATE:
                if (L & R)
                    next_state <= ALL_ON_STATE;
                else if (L & ~R)
                    next_state <= A_ON;
                else if (~L & R)
                    next_state <= A_ON;
                else
                    next_state <= OFF_STATE;

            ALL_ON_STATE:
                if (L & R)
                    next_state <= OFF_STATE;
                else
                    next_state <= OFF_STATE;

            A_ON:
                if ((L & ~R) || (~L & R))
                    if(L & ~R)
                    next_state <= A_F_ON;
                    else
                    next_state <= A_B_ON; //clockwise
                else
                    next_state <= OFF_STATE;

            A_F_ON:
                if (L & ~R)
                    next_state <= A_F_G_ON;
                else
                    next_state <= OFF_STATE;

            A_F_G_ON:
                if (L & ~R)
                    next_state <= A_F_G_B_ON;
                else
                    next_state <= OFF_STATE;

            A_F_G_B_ON:
                if (L & ~R)
                    next_state <= A_ON;
                else
                    next_state <= OFF_STATE;
                    
                    
                    
               //clockwise sequence

            A_B_ON:
                if (~L & R)
                    next_state <= A_B_G_ON;
                else
                    next_state <= OFF_STATE;

            A_B_G_ON:
                if (~L & R)
                    next_state <= A_F_G_B_ON;  
                else
                    next_state <= OFF_STATE;
         

            default: next_state <= OFF_STATE;

        endcase
        //Different combinations for our states
        CA = (state == A_ON || state == A_F_ON || state == A_F_G_ON ||state == A_F_G_B_ON || state == ALL_ON_STATE ||state ==A_B_ON || state == A_B_G_ON) ? 0 : 1;
        CB = (state == A_F_G_B_ON || state == ALL_ON_STATE || state ==A_B_ON || state == A_B_G_ON) ? 0 : 1;
        CF = (state == A_F_ON || state == A_F_G_ON || state ==A_F_G_B_ON || state == ALL_ON_STATE) ? 0 : 1;
        CG = (state == A_F_G_ON || state == A_F_G_B_ON || state ==ALL_ON_STATE || state == A_B_G_ON ) ? 0 : 1;
    end

endmodule