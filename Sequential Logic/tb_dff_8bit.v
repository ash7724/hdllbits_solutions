module tb_dff; 
  reg clk;
  reg [7:0]d;
  wire [7:0]q;

  dff dut(
    .clk(clk),
    .d(d),
    .q(q)
  );

  initial begin
    clk=0;
    d=8'h00;
    #10
    repeat(10) begin
    @(posedge clk);
      d= $urandom_range(0, 255);
      #10;
    end
  end
  always #10 clk = ~clk;
  
endmodule;
