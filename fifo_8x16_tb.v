`timescale 1ns / 1ps

module fifo_8x16_tb();
    reg clk,rst,wr_en,rd_en;
    reg [7:0] data_in;
    wire full,empty;
    wire [7:0] data_out;
    
fifo_8x16 uut (clk,rst,wr_en,rd_en,data_in,full,empty,data_out);

always #5 clk = ~clk;

task initialize();
     begin 
          clk=0;
          rst=0;
          data_in=0;
      end
endtask

task write();
     begin
       wr_en=1;
       rd_en=0;
       data_in = $random %60;
       #10;
     end 
endtask
 
task read();
     begin 
        wr_en=0;
        rd_en=1; 
        #10;  
     end
endtask 
 
 initial begin
      initialize();
      #10 rst=1;
      #10 rst=0;
      #10;
      repeat(30) write();
      #10;
      repeat(30) read();
     
 end
endmodule
