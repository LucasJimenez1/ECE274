`timescale 1ns/1ps
module vendingmachine_tb;

  // Inputs
  reg N_tb, D_tb, Q_tb, Clk_tb, Rst_tb;

  // Outputs
  wire [6:0]Number_tb;
  wire Candy_tb;

  // Instantiate the module
  VendingMachine uut (
    .Clk(Clk_tb),
    .Rst(Rst_tb),
    .N(N_tb),
    .D(D_tb),
    .Q(Q_tb),
   
    .Number(Number_tb),
    .Candy(Candy_tb)
  );
    // Monitor the outputs
    initial begin
        $monitor($time, " Number = %b Candy = %b", Number_tb, Candy_tb);
    end

  // Clock generation
  always begin
    Clk_tb <= 0;
    #10;
    Clk_tb <= 1;
    #10;
  end

  // Initial conditions
  initial begin
    Rst_tb <= 1;
    N_tb <= 0;
    D_tb <= 0;
    Q_tb <= 0;
    @(posedge Clk_tb);
    
    // Nickel

     Rst_tb <= 0;
    @(posedge Clk_tb);    
    @(posedge Clk_tb);

    // Case 2: More than 1 coin entered at any state
     @(posedge Clk_tb);   
     #5 N_tb = 1;
        @(posedge Clk_tb);    @(posedge Clk_tb);    @(posedge Clk_tb);    @(posedge Clk_tb);    @(posedge Clk_tb);
      N_tb = 0;
         @(posedge Clk_tb);    @(posedge Clk_tb);
    #5 Rst_tb = 1;   
         @(posedge Clk_tb);
     #5 Rst_tb = 0;
    
        
    // Case 3: Dime
  
    D_tb = 1;
      @(posedge Clk_tb);      @(posedge Clk_tb);    @(posedge Clk_tb);    @(posedge Clk_tb);    @(posedge Clk_tb);
      D_tb = 0;
          @(posedge Clk_tb);    @(posedge Clk_tb);
          
      #5 Rst_tb = 1;
         @(posedge Clk_tb);
      #5 Rst_tb = 0;

       
    // Case 4: Quarter
     Q_tb = 1;   
      @(posedge Clk_tb);    @(posedge Clk_tb);    @(posedge Clk_tb);    @(posedge Clk_tb);    @(posedge Clk_tb);
     Q_tb = 0;
     @(posedge Clk_tb);   
     @(posedge Clk_tb);   
     
    #5 Rst_tb = 1;
        @(posedge Clk_tb);
    #5  Rst_tb = 0;
    
    // 15 cents
    #10;
    D_tb = 1; 
        @(posedge Clk_tb);
    N_tb = 1;
        @(posedge Clk_tb);    @(posedge Clk_tb);
     
     D_tb = 0;
     @(posedge Clk_tb);   
     @(posedge Clk_tb);   
     N_tb = 0;
          @(posedge Clk_tb);   
     @(posedge Clk_tb);      
        
     #5 Rst_tb = 1;
        @(posedge Clk_tb);
    #5  Rst_tb = 0;       
        

    $stop;
  end

        


endmodule
