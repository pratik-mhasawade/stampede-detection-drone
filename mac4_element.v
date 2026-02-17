module mac4_element (
    input  wire clk,
    input  wire rst,          // synchronous active-high reset
    input  wire valid_in,

    input  wire signed [7:0] a0, a1, a2, a3,
    input  wire signed [7:0] b0, b1, b2, b3,

    output reg  signed [17:0] c_out,   // 18-bit safe width
    output reg  valid_out
);

    // =========================
    // Stage 1: Multiplication
    // =========================
    reg signed [15:0] p0_s1, p1_s1, p2_s1, p3_s1;
    reg valid_s1;

    always @(posedge clk) begin
        if (rst) begin
            p0_s1   <= 16'sd0;
            p1_s1   <= 16'sd0;
            p2_s1   <= 16'sd0;
            p3_s1   <= 16'sd0;
            valid_s1 <= 1'b0;
        end else begin
            p0_s1   <= a0 * b0;  // DSP inferred
            p1_s1   <= a1 * b1;
            p2_s1   <= a2 * b2;
            p3_s1   <= a3 * b3;
            valid_s1 <= valid_in;
        end
    end


    // =========================
    // Stage 2: First-Level Add
    // =========================
    reg signed [16:0] sum0_s2, sum1_s2;  // 17-bit
    reg valid_s2;

    always @(posedge clk) begin
        if (rst) begin
            sum0_s2 <= 17'sd0;
            sum1_s2 <= 17'sd0;
            valid_s2 <= 1'b0;
        end else begin
            sum0_s2 <= $signed(p0_s1) + $signed(p1_s1);
            sum1_s2 <= $signed(p2_s1) + $signed(p3_s1);
            valid_s2 <= valid_s1;
        end
    end


    // =========================
    // Stage 3: Final Add
    // =========================
    reg signed [17:0] sum_s3;  // 18-bit
    reg valid_s3;

    always @(posedge clk) begin
        if (rst) begin
            sum_s3  <= 18'sd0;
            valid_s3 <= 1'b0;
        end else begin
            sum_s3  <= $signed(sum0_s2) + $signed(sum1_s2);
            valid_s3 <= valid_s2;
        end
    end


    // =========================
    // Output Assignment
    // =========================
    always @(posedge clk) begin
        if (rst) begin
            c_out    <= 18'sd0;
            valid_out <= 1'b0;
        end else begin
            c_out    <= sum_s3;
            valid_out <= valid_s3;
        end
    end

endmodule
