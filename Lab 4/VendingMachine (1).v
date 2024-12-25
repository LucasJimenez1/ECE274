`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Unviersity of Arizona
// Engineer:
//
// Create Date: 10/09/2023 09:03:54 AM
// Design Name:
// Module Name: VendingMachine
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


module VendingMachine(
//inputs
input Clk,
input Rst,
input N,
input D,
input Q,

//outputs
output reg [6:0] Number, //Number to display
output reg Candy //candy LED for when 25c is inserted
);

    // State Definitions
    localparam [2:0]
        INITIAL_STATE = 0, // Initial state no cents in machine
        FIVE_CENT_STATE = 1, // 5 cents in machine
        TEN_CENT_STATE = 2, // 10 cents in machine
        FIFTEEN_CENT_STATE = 3, // 15 cents in machine
        TWENTY_CENT_STATE = 4, // 20 cents in machine
        TWENTYFIVE_CENT_STATE = 5, // 25 cents in machine, candy dispensed
        THIRTY_CENT_STATE = 6, // 30 cents in machine, display 5 cent refund
        THIRTYFIVE_CENT_STATE = 7, // 35 cents in machine, display 10 cent refund
        FORTY_CENT_STATE = 8, //40 cents in machine, display 15 cent refund
        FORTYFIVE_CENT_STATE = 9; //45 cents in machine, display 20 cent refund
   
    reg [2:0] state, next_state;

//return to INITAL state if Reset or move on to next state
    always @(posedge Clk or posedge Rst) begin
        if (Rst==1)
            state <= INITIAL_STATE;
        else
            state <= next_state;
    end
   

    always @(*) begin
        case (state)
            INITIAL_STATE:  //0c or Rst button
            begin
                Number <= 0;
                Candy <= 0;


                if (N)
                    next_state <= FIVE_CENT_STATE;
                else if (D)
                    next_state <= TEN_CENT_STATE;
                else if (Q)
                    next_state <= TWENTYFIVE_CENT_STATE;
                else 
                next_state <= INITIAL_STATE;                    
                    
               end            
                     
            FIVE_CENT_STATE: //5c
            begin
                Number <= 5;


           
                if (N)
                    next_state <= TEN_CENT_STATE;
                else if (D)
                    next_state <= FIFTEEN_CENT_STATE;
                else if (Q)
                    next_state <= THIRTY_CENT_STATE;
                 else 
                next_state <= FIVE_CENT_STATE;                   

             end
                                           
            TEN_CENT_STATE: //10c
            begin
                Number <= 10;


         
                if (N)
                    next_state <= FIFTEEN_CENT_STATE;
                else if (D)
                    next_state <= TWENTY_CENT_STATE;
                else if (Q)
                    next_state <= THIRTYFIVE_CENT_STATE;
                else 
                next_state <= TEN_CENT_STATE;

           end                      
                     
            FIFTEEN_CENT_STATE: //15c
            begin
                Number <= 15;


           
                if (N)
                    next_state <= TWENTY_CENT_STATE;
                else if (D)
                    next_state <= TWENTYFIVE_CENT_STATE;
                else if (Q)
                    next_state <= FORTY_CENT_STATE;
                else 
                next_state <= FIFTEEN_CENT_STATE;                    

            end                
       
            TWENTY_CENT_STATE:  //20c
            begin
                 Number <= 20;


                if (N)
                    next_state <= TWENTYFIVE_CENT_STATE;
                else if (D)
                    next_state <= THIRTY_CENT_STATE;
                else if (Q)
                    next_state <= FORTYFIVE_CENT_STATE;
                    
                else 
                next_state <= TWENTY_CENT_STATE;
                  
                    
             end        

            TWENTYFIVE_CENT_STATE:  //25c
            begin
                Candy <= 1;
                Number <= 0;
                next_state <= TWENTYFIVE_CENT_STATE;
               
            end    
       
            THIRTY_CENT_STATE:  //30c
            begin
                Candy <= 1;
                Number <= 5;
                next_state <= THIRTY_CENT_STATE;
            end    
       
            THIRTYFIVE_CENT_STATE:  //35c
            begin
                Candy <= 1;
                Number <= 10;
                next_state <= THIRTYFIVE_CENT_STATE;

            end    
       
            FORTY_CENT_STATE:   //40c
            begin  
                Candy <= 1;          
                Number <= 15;
                next_state <= FORTY_CENT_STATE;
            end    
                         
            FORTYFIVE_CENT_STATE:   //45c
            begin
                Candy <= 1;
                Number <= 20;
                next_state <= FORTYFIVE_CENT_STATE;                
            end          
                       
        endcase
       
       
        end
       
       
       
endmodule