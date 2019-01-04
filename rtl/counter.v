module counter (input clk,reset,load,ud,input [3:0]data_in,output reg [3:0]data_out);
always@(posedge clk)
begin
 if(reset)
  data_out<=0;
 else
  begin
    if(load)
      data_out<=data_in;
    else
      begin
        if(ud)
          begin
            if(data_out==15)
              data_out<=0;
            else
              data_out<=data_out+1;
          end
        else
          begin
            if(data_out==0)
              data_out<=15;
            else
              data_out<=data_out-1;
          end
      end
 end
end
/* 
property load_prty;
@(posedge clk) load&&~reset |=> data_out==$past(data_in,1);
endproperty

LP:assert property (load_prty);

property u_count_prty;
@(posedge clk) ud&& ~reset |=> (data_out==$past(data_out,1)+1'b1);
endproperty

UCP: assert property (u_count_prty);


property d_count_prty;
@(posedge clk) ud&& ~reset |=> (data_out==$past(data_out,1)-1'b1);
endproperty

DCP: assert property (d_count_prty);


property reset_prty;
@(posedge clk) reset |=> (data_out==4'b0);
endproperty

RP: assert property (reset_prty);


*/
endmodule

