        IDENTIFICATION DIVISION.
        PROGRAM-ID. snake.
        DATA DIVISION.
        FILE SECTION.
        WORKING-STORAGE SECTION.
        01 GameClock PIC 9(10).
        01 GameStart PIC 9(10).
        01 GameClockDiff PIC 9(10).
        01 GameCycle PIC 99 VALUE ZEROS.
        01 GameOverFlag PIC 9.
            88 GameOver VALUE 1.
            88 GameNotOver VALUE 0.
        01 Snake.
            02 SnakeSize PIC 999 VALUE 1.
            02 SnakeDirection PIC A VALUE 'R'.
                88 SnakeDirUp    VALUE 'U'.
                88 SnakeDirRight VALUE 'R'.
                88 SnakeDirDown  VALUE 'D'.
                88 SnakeDirLeft  VALUE 'L'.
            02 SnakeCoords OCCURS 1 TO 400 TIMES DEPENDING ON
             SnakeSize INDEXED BY SnakeCoordsI.
                03 SnakeCoordsX PIC 999.
                03 SnakeCoordsY PIC 999.
        01 SnakeOnFieldFlag PIC 9.
            88 SnakeOnField VALUE 1.
            88 SnakeNotOnField VALUE 0.
        01 Food.
            02 FoodCoords.
                03 FoodCoordsX PIC 999.
                03 FoodCoordsY PIC 999.
        01 Board.
            02 DrawFlag    PIC 9   VALUE 0.
                88 Draw            VALUE 1.
                88 DontDraw        VALUE 0.
            02 BoardI      PIC 999 VALUE 1.
            02 BoardJ      PIC 999 VALUE 1.
            02 BoardWidth  PIC 999 VALUE 50.
            02 BoardHeight PIC 999 VALUE 20.
            
        01 I PIC 999.
        01 J PIC 999.
        PROCEDURE DIVISION.

        GameLoop.
            CALL "ComputeMillis" USING GameStart.
            DISPLAY X"1b" "[2J"
            MOVE 25 TO SnakeCoordsX(1).
            MOVE 10 TO SnakeCoordsY(1).
            SET GameNotOver TO True.
            DISPLAY "Start".
            PERFORM DrawBoard.

            PERFORM UNTIL GameOver
                PERFORM CheckDrawCycle
                PERFORM MoveSnake
                DISPLAY X"1b" "[" BoardHeight "A"
                DISPLAY X"1b" "[" BoardWidth "D"
                PERFORM DrawBoard
                PERFORM BoundsCheck
            END-PERFORM.
            
            EXIT PROGRAM.

        DrawBoard.
            IF Draw THEN
                PERFORM VARYING BoardI FROM 1 BY 1 UNTIL
                 BoardI > BoardHeight
                    PERFORM VARYING BoardJ FROM 1 BY 1 UNTIL
                     BoardJ > BoardWidth
                        PERFORM CheckSnakeOnField
                        IF SnakeOnField THEN
                            DISPLAY "#" WITH NO ADVANCING
                        ELSE
                            DISPLAY "." WITH NO ADVANCING
                        END-IF
                    END-PERFORM
                    DISPLAY " "
                END-PERFORM
            END-IF.
            
        CheckDrawCycle.
            CALL "ComputeMillis" USING GameClock.
            SET DontDraw TO True.
            COMPUTE GameClockDiff = (GameClock - GameStart) / 500.
            IF GameClockDiff > GameCycle THEN
                IF GameClockDiff > 99 THEN
                    CALL "ComputeMillis" USING GameStart
                    MOVE 0 TO GameCycle
                ELSE
                    MOVE GameClockDiff TO GameCycle
                END-IF
                SET Draw TO True
            END-IF.

        CheckSnakeOnField.
            SET SnakeNotOnField TO True.
            PERFORM VARYING SnakeCoordsI FROM 1 BY 1 UNTIL
             SnakeCoordsI > SnakeSize
                IF SnakeCoordsX(SnakeCoordsI) = BoardJ
                 AND SnakeCoordsY(SnakeCoordsI) = BoardI
                    SET SnakeOnField TO True
                END-IF
            END-PERFORM.

        MoveSnake.
            IF Draw THEN
                PERFORM VARYING SnakeCoordsI FROM SnakeSize BY -1 UNTIL
                 SnakeCoordsI = 0
                    MOVE SnakeCoordsI TO I
                    MOVE SnakeCoordsI TO J
                    ADD 1 TO J
                
                    MOVE SnakeCoords(I) TO SnakeCoords(J)
                END-PERFORM
                IF SnakeDirUp THEN
                    SUBTRACT 1 FROM SnakeCoordsY(SnakeSize)
                ELSE IF SnakeDirLeft THEN
                    SUBTRACT 1 FROM SnakeCoordsX(SnakeSize)
                ELSE IF SnakeDirDown THEN
                    ADD 1 TO SnakeCoordsY(SnakeSize)
                ELSE IF SnakeDirRight THEN
                    ADD 1 TO SnakeCoordsX(SnakeSize)
                ELSE
                    DISPLAY "ERROR: Expected direction got '"
                     SnakeDirection "'"
                    STOP RUN
                END-IF END-IF END-IF END-IF
            END-IF.
            
        BoundsCheck.
            SET GameNotOver TO True.
