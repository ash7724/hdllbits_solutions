//Build a counter that counts from 0 to 999, inclusive, with a period of 1000 cycles. The reset input is synchronous, and should reset the counter to 0.

module top_module #(parameter count_val=999)(
    input clk,
    input reset,
    output [9:0] q);

  reg [9:0] counter;
  always @(posedge clk) begin
    if(reset)
      counter<=0;
    else if (counter==count_val)
      counter<=0;
   else
      counter<=counter+1'b1;
  end
  assign q= counter;
endmodule
