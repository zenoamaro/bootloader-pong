        mov cx, BG_C                    ; Clear screen to bg color
        call cls

draw_p1_score:
        mov dl, P1_SCORE_X
        mov dh, P1_SCORE_Y
        mov bl, P1_SCORE_C
        mov al, [p1_score]
        add al, 48                      ; Shift to `0` character
        call plotc
draw_p2_score:
        mov dl, P2_SCORE_X
        mov dh, P2_SCORE_Y
        mov bl, P2_SCORE_C
        mov al, [p2_score]
        add al, 48                      ; Shift to `0` character
        call plotc

draw_p1:
        mov ax, [p1_y]
        mov bx, P1_X
        mov cx, P1_H
        mov dl, P1_C
draw_p1_paddle:
        call plot
        inc ax
        loop draw_p1_paddle            ; Loop to size of paddle

draw_p2:
        mov ax, [p2_y]
        mov bx, P2_X
        mov cx, P2_H
        mov dl, P2_C
draw_p2_paddle:
        call plot
        inc ax
        loop draw_p2_paddle            ; Loop to size of paddle

draw_ball:
        mov ax, [ball_y]
        mov bx, [ball_x]
        mov dl, BALL_C
        call plot
