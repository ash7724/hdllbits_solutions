module tb_dff; 
  reg clk;
  reg d;
  wire q;

  dff dut(
    .clk(clk),
    .d(d),
    .q(q)
  );

  initial begin
    clk=0;
    d=0;
  end
  always #10 clk = ~clk;
  
endmodule;
