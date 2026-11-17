module binary(
    input w,
    input clk,
    input reset,
    output z,
    output [2:0] State
);

    wire [2:0] Next;
    wire [2:0] Current;

    // Three D flip-flops
    dff DFF0(
        .Default(1'b0),
        .D(Next[0]),
        .clk(clk),
        .Q(Current[0])
    );

    dff DFF1(
        .Default(1'b0),
        .D(Next[1]),
        .clk(clk),
        .Q(Current[1])
    );

    dff DFF2(
        .Default(1'b0),
        .D(Next[2]),
        .clk(clk),
        .Q(Current[2])
    );

    // Output logic
    assign z = Current[2] | (Current[1] & ~Current[0]);

    // Next-state logic
    assign Next[2] = reset ? 1'b0 :
                     (w & (Current[2] | (Current[1] & Current[0])));

    assign Next[1] = reset ? 1'b0 :
                     ((Current[1] ^ Current[0]) |
                     (w & ~Current[1] & ~Current[2]));

    assign Next[0] = reset ? 1'b0 :
                     ((~w & ((Current[1] & Current[0]) |
                     (~Current[1] & ~Current[0]))) |
                     (w & ~Current[2] & (~Current[1] | ~Current[0])));

    // Expose current state for the LEDs
    assign State = Current;

endmodule