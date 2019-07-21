init: ;-------------------------------------------------------------------------
        neg word [ball_xs]              ; Invert horizontal direction
        mov [ball_x], word BALL_START_X ; Ball at starting position
        mov [ball_y], word BALL_START_Y

loop: ;-------------------------------------------------------------------------
        %include "src/update.asm"
        %include "src/draw.asm"


spin: ;-------------------------------------------------------------------------
        call sleep                      ; FIXME: Proper timestep
        jmp loop


states: ;-----------------------------------------------------------------------

state_p1_scored:
        inc byte [p1_score]
        cmp [p1_score], byte MAX_SCORE
        jge state_game_over
        jmp init
state_p2_scored:
        inc byte [p2_score]
        cmp [p2_score], byte MAX_SCORE
        jge state_game_over
        jmp init

state_game_over:
        mov cx, GAME_OVER_L             ; String index from end
        mov dl, GAME_OVER_X
        mov dh, GAME_OVER_Y
        mov di, game_over_s
        mov bl, GAME_OVER_C             ; Color
state_game_over_print:
        mov al, [di]
        push cx
        call plotc
        inc dl
        inc di
        pop cx
        loop state_game_over_print
state_game_over_spin:
        jmp state_game_over_spin
