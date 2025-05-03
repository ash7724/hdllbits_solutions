module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    reg [2:0] state,next;
    reg [2:0] count;
    
    localparam  s_0=0,
    			s_1=1,
    			s_11=2,
    			s_110=3,
    			s_1101=4,
    			s_count=5,
				s_wait_ack=6;
    
    always @(posedge clk) begin
        if(reset) 	state<=s_0;
        else 		state<=next;
    end
    
    always @(*) begin
        next=state;
        case(state)
            s_0   : if(data) 		next=s_1;
            		else 			next=s_0;
            s_1   : if(data) 		next=s_11;
            		else 			next=s_0;
            s_11  : if(data) 		next=s_11;
            		else 			next=s_110;        
            s_110 :	if(data) 		next=s_1101;
            		else 			next=s_0;        
            s_1101: if(count==0) 	next=s_count;
            		else 			next=s_1101;
            s_count:if(done_counting) 	next=s_wait_ack;
            		else 			next=s_count;
            s_wait_ack: if(ack) 	next=s_0;
            		else 			next=s_wait_ack;
            default:				next=s_0;
        endcase
    end
    
    always @(*) begin
        shift_ena=0;
        counting=0;
        done=0;
        case(state)
        	s_0			:	done=1'b0;
        	s_1101		:   shift_ena=1;
            s_count	  	:
                begin
                			counting=1'b1;
                			shift_ena=1'b0;                
            end
            s_wait_ack: 
                begin 
                			counting=1'b0;
               			 	done=1'b1;
            end
        endcase
    end
    
    always @(posedge clk) begin
        count<=3;
        case(state)
        	s_1101:begin
            	if(count!=0)
                	count<=count-1'b1;
            	else
                	count<=count;
        	end   
        endcase
    end    
            
endmodule
