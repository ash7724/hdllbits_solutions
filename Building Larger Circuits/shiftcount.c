/*
  Build a four-bit shift register that also acts as a down counter. 
  Data is shifted in most-significant-bit first when shift_ena is 1. 
  The number currently in the shift register is decremented when count_ena is 1
*/
module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    reg [3:0] q_reg;
    always @(posedge clk) begin
        if(shift_ena)begin
            q_reg[0]	<=data;
            q_reg[3:1]	<=q_reg[2:0];
            //q_reg<={q_reg[2:0],data};
        end
        else if(count_ena)
            q_reg	<=q_reg-1'b1;
        else
            q_reg<=q_reg;
    end
    assign q=q_reg;
endmodule
