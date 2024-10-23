/****************************************************************
 - Project        : DSD Personal Project
 - File name      : FIR_Filter_tb_001.v
 - Description    : FIR Filter testbench when input value is positive
 - Owner          : Hyuntaek.Jung
 - Revision History : 1) 2024.10.22 : Initial release
****************************************************************/
`timescale 1ns/10ps

module FIR_Filter_tb_001;

    reg iClk_12MHz; // 12MHz clock
    reg iRsn; // Reset signal
    reg [2:0] iFirIn; // 3-bit input
    reg iEnSample_600kHz; // Enable sample signal for 600kHz

    wire [15:0] oFirOut;
    
    // FIR Filter instantiation
<<<<<<< HEAD
    FIR_Filter UUT (
=======
    FIR_Filter_1 UUT (
>>>>>>> d93c8b182d026d3440c1586a2517c542172d8ceb
        .iClk_12MHz(iClk_12MHz),
        .iRsn(iRsn),
        .iFirIn(iFirIn),
        .iEnSample_600kHz(iEnSample_600kHz),
        .oFirOut(oFirOut)
    );

    always @(posedge iEnSample_600kHz) begin
        $display("Time: %0t ns, oFirOut: %b", $time, oFirOut);
    end

    /***********************************************
    // Clock definition (12MHz)
    ***********************************************/
    initial begin
        iClk_12MHz = 0;
    end
    always begin
        #41.67 iClk_12MHz = ~iClk_12MHz; // 12MHz clock -> Period = 83.33ns
    end

    /***********************************************
    // Synchronous & active low reset definition
    ***********************************************/
    initial begin
        iRsn <= 1'b1;
        iEnSample_600kHz = 1'b0;
        iFirIn = 3'b000;
        repeat (2) @(posedge iClk_12MHz);
        iRsn <= 1'b0;
        repeat (2) @(posedge iClk_12MHz);
        $display("------------------------------------------------->");
        $display("**** Active low reset released !!! ****");
        iRsn <= 1'b1;
        $display("------------------------------------------------->");
    end

    integer cycle_count; // 카운터 변수

    initial begin
        cycle_count = 0; // 카운터 초기화
<<<<<<< HEAD
        repeat (150) begin
=======
        repeat (128) begin
>>>>>>> d93c8b182d026d3440c1586a2517c542172d8ceb
            if (cycle_count == 0) begin
                // 64번째 주기마다 3'b001 입력
                iFirIn = 3'b001;
            end else begin
                // 나머지 63번은 3'b000 입력
                iFirIn = 3'b000;
            end

            iEnSample_600kHz <= 1'b1;
            @(posedge iClk_12MHz);
            iEnSample_600kHz <= 1'b0;
            #1666.67;  // Wait for the next 600kHz sample (1.6667 µs)

            // 카운터 갱신 (64번 주기마다 0으로 리셋)
            cycle_count = (cycle_count + 1) % 64;
        end
        repeat (200) @(posedge iClk_12MHz);
        $finish; // End the simulation after the input pattern
    end

    /***********************************************
    // Display time and oFirOut in binary format
    ***********************************************/

endmodule
