
/*
`timescale 1ns / 1ps

module Top_Design(CLK100MHZ, BTNC, SW, CA, CB, CF, CG);
    input CLK100MHZ, BTNC;
    input [1:0] SW; //SW[1] is L, SW[0] is R
    output CA, CB, CF, CG;
        
	//start writing your code below by instantiating the components
	//used for lab 3 top-level design which are ClkDiv and the light-sequence generator
	

    
endmodule
*/
`timescale 1ns / 1ps
/*
module Top_Design(
    input CLK100MHZ,
    input BTNC,
    input [1:0] SW, //SW[1] is L, SW[0] is R
    output reg CA,
    output reg CB,
    output reg CF,
    output reg CG
);

*/


module Top_Design(CLK100MHZ, BTNC, SW, CA, CB, CF, CG);

    input CLK100MHZ, BTNC;
    input [1:0] SW; //SW[1] is L, SW[0] is R
    output CA, CB, CF, CG;
    
    wire ClkOut;     // Connecting to ClkDiv's output
    wire Rst0 = BTNC; // Assuming you want to use the BTNC button for reset

    // initiating the ClkDiv component
    ClkDiv clock_divider (
        .Clk(CLK100MHZ),
        .Rst(Rst0),
        .ClkOut(ClkOut)
    );
    
        Lab3_partA light_sequence (
        .Clk(ClkOut),
        .Rst(Rst0),
        .L(SW[1]),
        .R(SW[0]),
        .CA(CA),
        .CB(CB),
        .CF(CF),
        .CG(CG)
    );
    
    
    
    /*
    
        // Define the states using local parameters
    localparam OFF_STATE = 3'b000; //when off
    localparam ALL_ON_STATE = 3'b001; //when on
    localparam A_ON = 3'b010; //A on
    localparam A_F_ON = 3'b011; //A & F on
    localparam A_F_G_ON = 3'b100; // A & F & G on
    localparam A_F_G_B_ON = 3'b101; //A & F & G & B on
    localparam B_ON = 3'b110; //B on 
    localparam G_ON = 3'b111; // G on

    reg [2:0] state, next_state;
    
    
    
    
//Begin with off state if Rest or move on to next stae
    always @(posedge CLK100MHZ or posedge BTNC) begin
        if (BTNC)
            state <= OFF_STATE;
        else
            state <= next_state;
    end

    // Defining different state logics
    always @(*) begin
        case (state)
            OFF_STATE:
                if (SW[1] & SW[0])
                    next_state <= ALL_ON_STATE;
                else if (SW[1] & ~SW[0])
                    next_state <= A_ON;
                else if (~SW[1] & SW[0])
                    next_state <= B_ON;
                else
                    next_state <= OFF_STATE;

            ALL_ON_STATE:
                if (SW[1] & SW[0])
                    next_state <= OFF_STATE;
                else
                    next_state <= OFF_STATE;

            A_ON:
                if (SW[1] & ~SW[0])
                    next_state <= A_F_ON;
                else
                    next_state <= OFF_STATE;

            A_F_ON:
                if (SW[1] & ~SW[0])
                    next_state <= A_F_G_ON;
                else
                    next_state <= OFF_STATE;

            A_F_G_ON:
                if (SW[1] & ~SW[0])
                    next_state <= A_F_G_B_ON;
                else
                    next_state <= OFF_STATE;

            A_F_G_B_ON:
                if (SW[1] & ~SW[0])
                    next_state <= A_ON;
                else
                    next_state <= OFF_STATE;

            B_ON:
                if (~SW[1] & SW[0])
                    next_state <= G_ON;
                else
                    next_state <= OFF_STATE;

            G_ON:
                if (~SW[1] & SW[0])
                    next_state <= A_ON;  
                else
                    next_state <= OFF_STATE;

            default: next_state <= OFF_STATE;

        endcase
        //Different combinations for our states
        CA = (state == A_ON || state == A_F_ON || state == A_F_G_ON ||state == A_F_G_B_ON || state == ALL_ON_STATE) ? 0 : 1;
        CB = (state == A_F_G_B_ON || state == ALL_ON_STATE || state ==B_ON) ? 0 : 1;
        CF = (state == A_F_ON || state == A_F_G_ON || state ==A_F_G_B_ON || state == ALL_ON_STATE) ? 0 : 1;
        CG = (state == A_F_G_ON || state == A_F_G_B_ON || state ==ALL_ON_STATE || state == G_ON) ? 0 : 1;
    end


*/
endmodule