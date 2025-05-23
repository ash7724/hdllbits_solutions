/*
Derive next-state logic equations and output logic equations by inspection assuming the following one-hot encoding is used: (S, S1, S11, S110, B0, B1, B2, B3, Count, Wait) = 
(10'b0000000001, 10'b0000000010, 10'b0000000100, ... , 10'b1000000000)
Derive state transition and output logic equations by inspection assuming a one-hot encoding. 
Implement only the state transition logic and output logic (the combinational logic portion) for this state machine. 
(The testbench will test with non-one hot inputs to make sure you're not trying to do something more complicated.
See fsm3onehot for a description of what is meant by deriving logic equations "by inspection" for one-hot state machines.)

https://hdlbits.01xz.net/wiki/Exams/review2015_fsmonehot
*/

module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
); //
    
    //reg [9:0] state;
    // You may use these parameters to access state bits using e.g., state[B2] instead of state[6].
    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, Count=8, Wait=9;

    assign B3_next =state[6];
    assign S_next  = (state[1] & ~d) || (state[0] & ~d) || (state[3] & ~d) || (state[9] & ack);
    assign S1_next = (state[0] & d);
    assign Count_next = state[7] || (state[8] & ~done_counting);
    assign Wait_next = (state[8] & done_counting) || (state[9] & ~ack)  ;
    assign done = state[9];
    assign counting = state[8];
    assign shift_ena =  (state[4] || state[5] || state[6] ||  state[7]) ;

endmodule
