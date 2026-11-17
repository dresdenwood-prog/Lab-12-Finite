module top(
    input sw,
    input btnC,
    input btnU,
    output [9:0] led
);

    wire one_hot_z;
    wire binary_z;

    wire [4:0] one_hot_state;
    wire [2:0] binary_state;

    // One-hot state machine
    one_hot OH(
        .w(sw),
        .clk(btnC),
        .reset(btnU),
        .z(one_hot_z),
        .State(one_hot_state)
    );

    // Binary state machine
    binary BIN(
        .w(sw),
        .clk(btnC),
        .reset(btnU),
        .z(binary_z),
        .State(binary_state)
    );

    // Output LEDs
    assign led[0] = one_hot_z;
    assign led[1] = binary_z;

    // One-hot state LEDs
    assign led[2] = one_hot_state[0]; // A
    assign led[3] = one_hot_state[1]; // B
    assign led[4] = one_hot_state[2]; // C
    assign led[5] = one_hot_state[3]; // D
    assign led[6] = one_hot_state[4]; // E

    // Binary state LEDs
    assign led[9:7] = binary_state;

endmodule
