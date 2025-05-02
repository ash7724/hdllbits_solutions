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

//Build a counter that counts from 0 to 999, inclusive, with a period of 1000 cycles. The reset input is synchronous, and should reset the counter to 0.
//Second approach segrregating combo and sequential circuit
module top_module  #(parameter count_val=999) (
    input clk,
    input reset,
    output [9:0] q);
   
    reg [9:0] q_reg,q_next;
    always @(posedge clk) begin
        if(reset)
            q_reg<='h0;
        else
            q_reg<=q_next;
    end
    assign q_next=(q_reg==count_val) ? 10'h0 : q_reg+1'b1;
    assign q=q_reg;
endmodule
