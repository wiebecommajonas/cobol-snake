        IDENTIFICATION DIVISION.
        PROGRAM-ID. Test.
        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
            SELECT SYSIN ASSIGN TO KEYBOARD
             ORGANIZATION IS SEQUENTIAL
             ACCESS MODE  IS SEQUENTIAL.
        DATA DIVISION.
        FILE SECTION.
        FD SYSIN.
        01 Char PIC X.
        WORKING-STORAGE SECTION.
        01 CmdSetEcho   PIC X(9)  VALUE "stty echo".
        01 CmdUnsetEcho PIC X(10) VALUE "stty -echo".
        01 WsText       PIC X.
        77 Eof PIC 9 VALUE ZERO.
        PROCEDURE DIVISION.
        Main.
            DISPLAY SPACE
                WITH BLANK SCREEN
            END-DISPLAY.
            ACCEPT WsText
                LINE 2 COLUMN 3
                WITH AUTO
                WITH SIZE 1
            END-ACCEPT.
            DISPLAY WsText.
            STOP RUN.
