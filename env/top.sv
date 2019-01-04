`include"test.sv"
module top;
bit clk;

always #5 clk=~clk;

cif DUV_IF(clk);
counter DUV(.clk(DUV_IF.clk),.reset(DUV_IF.reset),.load(DUV_IF.load),.ud(DUV_IF.ud),.data_in(DUV_IF.data_in),.data_out(DUV_IF.data_out));

initial
 begin
  test t=new(DUV_IF,DUV_IF,DUV_IF);
  t.build_run;
 end

endmodule
  

