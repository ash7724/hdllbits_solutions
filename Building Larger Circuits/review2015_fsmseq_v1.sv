/*
Build a finite-state machine that searches for the sequence 1101 in an input bit stream. 
When the sequence is found, it should set start_shifting to 1, forever, until reset. 
Getting stuck in the final state is intended to model going to other states in a bigger FSM that is not yet implemented. 
We will be extending this FSM in the next few exercises.
*/
module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output reg start_shifting);
    
    //reg [2:0] state, next;
    enum { s_0,s_1,s_11,s_110,s_1101} state,next;
   
    always @(posedge clk) begin
        if(reset) 	state<=s_0;
        else 		state<=next;
    end

    always @(*) begin
        next=state;
        start_shifting=1'b0;
        case(state)
            s_0:begin 
                if(data) 	next=s_1;
            	else 		next=s_0;
        					start_shifting=1'b0;
            end
            s_1:if(data) 	next=s_11;
            	else 		next=s_0;
           s_11:if(data) 	next=s_11;
            	else 		next=s_110;
          s_110:if(data) 	next=s_1101;
            	else 		next=s_0;        
         s_1101:begin		next=s_1101;
        					start_shifting=1'b1;
         end
            	
        endcase;
    end 
endmodule
