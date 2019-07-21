init: ;-------------------------------------------------------------------------
        neg word [Ball.xs]              ; Invert horizontal direction
        mov [Ball.x], word Ball.x0      ; Ball at starting position
        mov [Ball.y], word Ball.y0

loop: ;-------------------------------------------------------------------------
        %include "src/update.asm"
        %include "src/draw.asm"


spin: ;-------------------------------------------------------------------------
        call Sleep                      ; FIXME: Proper timestep
        jmp loop


states: ;-----------------------------------------------------------------------

state_p1_scored:
        inc byte [P1.score.v]           ; Inc score
        cmp [P1.score.v], byte GameOver.score ; If player won
        jge state_game_over             ; Game over
        jmp init                        ; Restart match
state_p2_scored:
        inc byte [P2.score.v]           ; Inc score
        cmp [P2.score.v], byte GameOver.score ; if player won
        jge state_game_over             ; Game over
        jmp init                        ; Restart match

state_game_over:
        mov di, GameOver.s              ; String pointer
        mov cx, GameOver.l              ; String index from end
        mov dl, GameOver.x              ; X
        mov dh, GameOver.y              ; Y
        mov bl, GameOver.c              ; Color
state_game_over_print:
        mov al, [di]                    ; Get actual char
        push cx
        call PlotChar                   ; Plot char
        inc dl                          ; One x forward
        inc di                          ; One char forward
        pop cx
        loop state_game_over_print      ; Loop until string end
state_game_over_spin:
        jmp state_game_over_spin        ; Spin forever
