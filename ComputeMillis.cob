        IDENTIFICATION DIVISION.
        PROGRAM-ID. ComputeMillis.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 DateTime.
            02 WS-Date.
                03 WS-Year PIC 9999.
                03 WS-Month PIC 99.
                03 WS-Day PIC 99.
            02 WS-Time.
                03 Hours PIC 99.
                03 Minutes PIC 99.
                03 Seconds PIC 99.
                03 Milliseconds PIC 99.
            02 GmtOffset PIC S9999.
        LINKAGE SECTION.
        01 MillisResult PIC 9(10).
        PROCEDURE DIVISION USING MillisResult.
        Main.
            MOVE FUNCTION CURRENT-DATE TO DateTime.
            COMPUTE MillisResult = (((((WS-Year * 12 + WS-Month)
                                 * 30 + WS-Day) * 24 + Hours)
                                 * 60 + Minutes) * 60 + Seconds)
                                 * 1000 + Milliseconds * 100.
            EXIT PROGRAM.
