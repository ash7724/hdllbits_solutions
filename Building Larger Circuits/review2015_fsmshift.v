/* 
As part of the FSM for controlling the shift register, 
we want the ability to enable the shift register for exactly 4 clock cycles whenever the proper bit pattern is detected. 
We handle sequence detection in review2015_fsmseq, 
so this portion of the FSM only handles enabling the shift register for 4 cycles.
*/
module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    reg [2:0] count;
    always @(posedge clk) begin
        if(reset)
           count<=4;
        else if(count!=0)
           count<=count-1'b1;
    end
    assign shift_ena= (count!=0);
endmodule
