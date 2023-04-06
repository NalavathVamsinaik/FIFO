`timescale 1ns / 1ps


module fifo_8x16(
   
   input clk,rst,wr_en,rd_en,
   input [7:0]data_in,
   output full,empty,
   output reg[7:0]data_out
   
   
   );
   
   reg [3:0]wr_ptr,rd_ptr;
   reg [4:0]counter;
   integer i;
   
   reg[7:0]  MEM[15:0];
   
// WRITING INTO THE FIFO

always@(posedge clk)

  begin 
     if(rst)
       begin
         for(i=0;i<16;i=i+1)
           begin 
           MEM[i] <= 0;
           wr_ptr <= 0;
         end
       end
       
      else if (wr_en && ~full)
        begin
        
           MEM[wr_ptr] <= data_in;
           wr_ptr <= wr_ptr + 1'b1;
           
        end      
      else    
       begin 
         wr_ptr <= wr_ptr;
       end 
     end

//READING INTO THE FIFO

always@(posedge clk)
    begin
      if(rst)
        begin 
          rd_ptr <= 0;
          data_out <= 0;
        end 
       
       else if(rd_en && ~empty)
         begin
           data_out <= MEM[rd_ptr];
           rd_ptr = rd_ptr + 1'b1;
         end
      else
        begin 
          rd_ptr <= rd_ptr;
        end
      end

// COUNTER

always@(posedge clk)

begin
  if(rst)
   counter <= 5'b0;
  else if (wr_en && ~full)
    counter <= counter +1;
   else if(rd_en && ~empty)
     counter <= counter -1'b1;
   end

assign full = (counter == 5'd15)?1:0;
assign empty = (counter == 5'd0)?1:0;          
   
   
endmodule
