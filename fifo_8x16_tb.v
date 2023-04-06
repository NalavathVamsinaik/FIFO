`timescale 1ns / 1ps


module fifo_8x16_tb();
     
     reg clk, rst, wr_en, rd_en;
     reg [7:0]data_in;
     
     wire full,empty;
     wire [7:0]data_out;
     
fifo_8x16 dut (clk,rst,wr_en,rd_en,data_in,full,empty,data_out);

task instalizer();
    begin 
      clk = 0;
      rst =0;
      data_in =0;
      wr_en = 0;
      rd_en = 0;
    end
endtask 



task write();
      begin
       wr_en = 1;
       rd_en = 0;
       data_in = $random;
      end 
endtask 

task read();
   begin 
      wr_en = 0;
      wr_en = 1;
    end
endtask 



endmodule
