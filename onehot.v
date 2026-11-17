
module one_hot(
    input w,
    input clk,
    input reset,
    output z,
    output [4:0] State
);

    wire Anext, Bnext, Cnext, Dnext, Enext;
    wire Astate, Bstate, Cstate, Dstate, Estate;

    // Five D flip-flops
    dff Adff(
        .Default(1'b1),
        .D(Anext),
        .clk(clk),
        .Q(Astate)
    );

    dff Bdff(
        .Default(1'b0),
        .D(Bnext),
        .clk(clk),
        .Q(Bstate)
    );

    dff Cdff(
        .Default(1'b0),
        .D(Cnext),
        .clk(clk),
        .Q(Cstate)
    );

    dff Ddff(
        .Default(1'b0),
        .D(Dnext),
        .clk(clk),
        .Q(Dstate)
    );

    dff Edff(
        .Default(1'b0),
        .D(Enext),
        .clk(clk),
        .Q(Estate)
    );

    assign z = Cstate | Estate;

    // Next-state logic
    assign Anext = reset ? 1'b1 : 1'b0;
    assign Bnext = reset ? 1'b0 : (~w & (Astate | Dstate | Estate));
    assign Cnext = reset ? 1'b0 : (~w & (Bstate | Cstate));
    assign Dnext = reset ? 1'b0 : (w & (Astate | Bstate | Cstate));
    assign Enext = reset ? 1'b0 : (w & (Dstate | Estate));

    // Expose states for the LEDs
    assign State = {Estate, Dstate, Cstate, Bstate, Astate};

endmodule
