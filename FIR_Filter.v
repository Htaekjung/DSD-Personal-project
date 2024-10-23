/****************************************************************
 - Project        : DSD Personal Project
 - File name      : FIR_Filter.v
 - Description    : FIR Filter design
 - Owner          : Hyuntaek.Jung
 - Revision History : 1) 2024.10.22 : Initial release
****************************************************************/
module FIR_Filter (
    // Clock & reset
    input iClk_12MHz,   // 클록 주파수를 12MHz로 수정               
    input iRsn,         // Reset 신호                    

    // In & out enable signals
    input iEnSample_600kHz,        

    // Signed data input signal
    input signed [2:0] iFirIn,

    // Signed data output Signal
    output reg [15:0] oFirOut          
);

    /*********************************************
    // Wire & register declaration
    *********************************************/
    // Data input latch
    wire signed [15:0] coeff [0:32];       // 21개의 계수
    reg signed [15:0] shift_reg [0:32];   // 레지스터
    reg signed [15:0] Sum;

    wire signed [2:0] signed_iFirIn = iFirIn;
    // FirInDelay signals for shift register
    wire signed [15:0] FirIn_Delay_1st;
    wire signed [15:0] FirIn_Delay_2nd;
    wire signed [15:0] FirIn_Delay_3rd;
    wire signed [15:0] FirIn_Delay_4th;
    wire signed [15:0] FirIn_Delay_5th;
    wire signed [15:0] FirIn_Delay_6th;
    wire signed [15:0] FirIn_Delay_7th;
    wire signed [15:0] FirIn_Delay_8th;
    wire signed [15:0] FirIn_Delay_9th;
    wire signed [15:0] FirIn_Delay_10th;
    wire signed [15:0] FirIn_Delay_11th;
    wire signed [15:0] FirIn_Delay_12th;
    wire signed [15:0] FirIn_Delay_13th;
    wire signed [15:0] FirIn_Delay_14th;
    wire signed [15:0] FirIn_Delay_15th;
    wire signed [15:0] FirIn_Delay_16th;
    wire signed [15:0] FirIn_Delay_17th;
    wire signed [15:0] FirIn_Delay_18th;
    wire signed [15:0] FirIn_Delay_19th;
    wire signed [15:0] FirIn_Delay_20th;
    wire signed [15:0] FirIn_Delay_21th;
    wire signed [15:0] FirIn_Delay_22th;
    wire signed [15:0] FirIn_Delay_23th;
    wire signed [15:0] FirIn_Delay_24th;
    wire signed [15:0] FirIn_Delay_25th;
    wire signed [15:0] FirIn_Delay_26th;
    wire signed [15:0] FirIn_Delay_27th;
    wire signed [15:0] FirIn_Delay_28th;
    wire signed [15:0] FirIn_Delay_29th;
    wire signed [15:0] FirIn_Delay_30th;
    wire signed [15:0] FirIn_Delay_31th;
    wire signed [15:0] FirIn_Delay_32th;
    wire signed [15:0] FirIn_Delay_33th;
    integer i;

    wire signed [15:0] Fir_Sum_1st;
    wire signed [15:0] Fir_Sum_2nd;
    wire signed [15:0] Fir_Sum_3rd;
    wire signed [15:0] Fir_Sum_4th;
    wire signed [15:0] Fir_Sum_5th;
    wire signed [15:0] Fir_Sum_6th;
    wire signed [15:0] Fir_Sum_7th;
    wire signed [15:0] Fir_Sum_8th;
    wire signed [15:0] Fir_Sum_9th;
    wire signed [15:0] Fir_Sum_10th;
    wire signed [15:0] Fir_Sum_11th;
    wire signed [15:0] Fir_Sum_12th;
    wire signed [15:0] Fir_Sum_13th;
    wire signed [15:0] Fir_Sum_14th;
    wire signed [15:0] Fir_Sum_15th;
    wire signed [15:0] Fir_Sum_16th;
    wire signed [15:0] Fir_Sum_17th;
    wire signed [15:0] Fir_Sum_18th;
    wire signed [15:0] Fir_Sum_19th;
    wire signed [15:0] Fir_Sum_20th;
    wire signed [15:0] Fir_Sum_21th;
    wire signed [15:0] Fir_Sum_22th;
    wire signed [15:0] Fir_Sum_23th;
    wire signed [15:0] Fir_Sum_24th;
    wire signed [15:0] Fir_Sum_25th;
    wire signed [15:0] Fir_Sum_26th;
    wire signed [15:0] Fir_Sum_27th;
    wire signed [15:0] Fir_Sum_28th;
    wire signed [15:0] Fir_Sum_29th;
    wire signed [15:0] Fir_Sum_30th;
    wire signed [15:0] Fir_Sum_31th;
    wire signed [15:0] Fir_Sum_32th;
    wire signed [15:0] Fir_Sum_33th;

    /*********************************************
    // Coefficient assign 방식으로 정의
    *********************************************/
    assign coeff[0] = 16'h0003;
    assign coeff[1] = 16'h0000;
    assign coeff[2] = 16'h0065;
    assign coeff[3] = 16'h006E;
    assign coeff[4] = 16'h0000;
    assign coeff[5] = 16'h03F2;
    assign coeff[6] = 16'h000D;
    assign coeff[7] = 16'h0000;
    assign coeff[8] = 16'h0013;
    assign coeff[9] = 16'h0018;
    assign coeff[10] = 16'h0000;
    assign coeff[11] = 16'h0025;
    assign coeff[12] = 16'h0030;
    assign coeff[13] = 16'h0000;
    assign coeff[14] = 16'h0066;
    assign coeff[15] = 16'h00CE;
    assign coeff[16] = 16'h01F4;
    assign coeff[17] = 16'h00CE;
    assign coeff[18] = 16'h0066;
    assign coeff[19] = 16'h0000;
    assign coeff[20] = 16'h0030;
    assign coeff[21] = 16'h0025;
    assign coeff[22] = 16'h0000;
    assign coeff[23] = 16'h0018;
    assign coeff[24] = 16'h0013;
    assign coeff[25] = 16'h0000;
    assign coeff[26] = 16'h000D;
    assign coeff[27] = 16'h03F2;
    assign coeff[28] = 16'h0000;
    assign coeff[29] = 16'h006E;
    assign coeff[30] = 16'h0065;
    assign coeff[31] = 16'h0000;
    assign coeff[32] = 16'h0003;

    /*********************************************
    // Assign FirIn_Delay signals
    *********************************************/
    assign FirIn_Delay_1st = shift_reg[0];
    assign FirIn_Delay_2nd = shift_reg[1];
    assign FirIn_Delay_3rd = shift_reg[2];
    assign FirIn_Delay_4th = shift_reg[3];
    assign FirIn_Delay_5th = shift_reg[4];
    assign FirIn_Delay_6th = shift_reg[5];
    assign FirIn_Delay_7th = shift_reg[6];
    assign FirIn_Delay_8th = shift_reg[7];
    assign FirIn_Delay_9th = shift_reg[8];
    assign FirIn_Delay_10th = shift_reg[9];
    assign FirIn_Delay_11th = shift_reg[10];
    assign FirIn_Delay_12th = shift_reg[11];
    assign FirIn_Delay_13th = shift_reg[12];
    assign FirIn_Delay_14th = shift_reg[13];
    assign FirIn_Delay_15th = shift_reg[14];
    assign FirIn_Delay_16th = shift_reg[15];
    assign FirIn_Delay_17th = shift_reg[16];
    assign FirIn_Delay_18th = shift_reg[17];
    assign FirIn_Delay_19th = shift_reg[18];
    assign FirIn_Delay_20th = shift_reg[19];
    assign FirIn_Delay_21th = shift_reg[20];
    assign FirIn_Delay_22th = shift_reg[21];
    assign FirIn_Delay_23th = shift_reg[22];
    assign FirIn_Delay_24th = shift_reg[23];
    assign FirIn_Delay_25th = shift_reg[24];
    assign FirIn_Delay_26th = shift_reg[25];
    assign FirIn_Delay_27th = shift_reg[26];
    assign FirIn_Delay_28th = shift_reg[27];
    assign FirIn_Delay_29th = shift_reg[28];
    assign FirIn_Delay_30th = shift_reg[29];
    assign FirIn_Delay_31th = shift_reg[30];
    assign FirIn_Delay_32th = shift_reg[31];
    assign FirIn_Delay_33th = shift_reg[32];


    assign Fir_Sum_1st = shift_reg[0] * coeff[0];
    assign Fir_Sum_2nd = shift_reg[1] * coeff[1];
    assign Fir_Sum_3rd = shift_reg[2] * coeff[2];
    assign Fir_Sum_4th = shift_reg[3] * coeff[3];
    assign Fir_Sum_5th = shift_reg[4] * coeff[4];
    assign Fir_Sum_6th = shift_reg[5] * coeff[5];
    assign Fir_Sum_7th = shift_reg[6] * coeff[6];
    assign Fir_Sum_8th = shift_reg[7] * coeff[7];
    assign Fir_Sum_9th = shift_reg[8] * coeff[8];
    assign Fir_Sum_10th = shift_reg[9] * coeff[9];
    assign Fir_Sum_11th = shift_reg[10] * coeff[10];
    assign Fir_Sum_12th = shift_reg[11] * coeff[11];
    assign Fir_Sum_13th = shift_reg[12] * coeff[12];
    assign Fir_Sum_14th = shift_reg[13] * coeff[13];
    assign Fir_Sum_15th = shift_reg[14] * coeff[14];
    assign Fir_Sum_16th = shift_reg[15] * coeff[15];
    assign Fir_Sum_17th = shift_reg[16] * coeff[16];
    assign Fir_Sum_18th = shift_reg[17] * coeff[17];
    assign Fir_Sum_19th = shift_reg[18] * coeff[18];
    assign Fir_Sum_20th = shift_reg[19] * coeff[19];
    assign Fir_Sum_21th = shift_reg[20] * coeff[20];
    assign Fir_Sum_22th = shift_reg[21] * coeff[21];
    assign Fir_Sum_23th = shift_reg[22] * coeff[22];
    assign Fir_Sum_24th = shift_reg[23] * coeff[23];
    assign Fir_Sum_25th = shift_reg[24] * coeff[24];
    assign Fir_Sum_26th = shift_reg[25] * coeff[25];
    assign Fir_Sum_27th = shift_reg[26] * coeff[26];
    assign Fir_Sum_28th = shift_reg[27] * coeff[27];
    assign Fir_Sum_29th = shift_reg[28] * coeff[28];
    assign Fir_Sum_30th = shift_reg[29] * coeff[29];
    assign Fir_Sum_31th = shift_reg[30] * coeff[30];
    assign Fir_Sum_32th = shift_reg[31] * coeff[31];
    assign Fir_Sum_33th = shift_reg[32] * coeff[32];
    /*********************************************
    // Input data latch with Sync. D-FF
    *********************************************/
    // Synchronous D-FF with data enable
    always @(posedge iClk_12MHz) begin
        // Sync. reset
        if (!iRsn) begin
            for (i = 0; i < 33; i = i + 1) begin
                shift_reg[i] <= 16'h0; // Initialize shift register
            end
            Sum <= 16'h0; // Initialize sum
            oFirOut <= 16'h0; // Initialize output
        end
        else if (iEnSample_600kHz) begin
            // Shift Register 동작
            shift_reg[0] <= iFirIn;  // Input sample 저장
            for (i = 1; i < 33; i = i + 1) begin
                shift_reg[i] <= shift_reg[i-1];  // Delay를 위해 shift register 사용
            end

            // Sum of all products
            Sum <= Fir_Sum_1st + Fir_Sum_2nd - Fir_Sum_3rd + 
                Fir_Sum_4th + Fir_Sum_5th - Fir_Sum_6th + 
                Fir_Sum_7th + Fir_Sum_8th - Fir_Sum_9th +
                Fir_Sum_10th + Fir_Sum_11th - Fir_Sum_12th +
                Fir_Sum_13th + Fir_Sum_14th - Fir_Sum_15th + 
                Fir_Sum_16th + Fir_Sum_17th + Fir_Sum_18th - 
                Fir_Sum_19th + Fir_Sum_20th + Fir_Sum_21th -
                Fir_Sum_22th + Fir_Sum_23th - Fir_Sum_24th -
                Fir_Sum_25th + Fir_Sum_26th + Fir_Sum_27th - 
                Fir_Sum_28th + Fir_Sum_29th + Fir_Sum_30th - 
                Fir_Sum_31th + Fir_Sum_32th + Fir_Sum_33th;

            // FIR filter 출력
            oFirOut <= Sum;
        end
    end

endmodule
