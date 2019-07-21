loop: ;-------------------------------------------------------------------------

update: ;-----------------------------------------------------------------------

update_player:
update_player_input:
        in al, KEYBOARD_PORT
        cmp al, KEY_W
        je update_player_move_up
        cmp al, KEY_S
        je update_player_move_down
        jmp update_player_move_end
update_player_move:
update_player_move_up:
        dec word [P1Y]
        jmp update_player_move_end
update_player_move_down:
        inc word [P1Y]
update_player_move_end:

update_ball:
update_ball_move:
update_ball_move_x:
        mov ax, [BallX]
        mov bx, [BallXS]
        add ax, bx
        jz update_ball_move_x_invert
        cmp ax, SCREEN_W
        jne update_ball_move_x_set
update_ball_move_x_invert:
        neg bx
        mov [BallXS], bx
update_ball_move_x_set:
        mov [BallX], ax
update_ball_move_x_end:
update_ball_move_y:
        mov ax, [BallY]
        mov bx, [BallYS]
        add ax, bx
        jz update_ball_move_y_invert
        cmp ax, SCREEN_H
        jne update_ball_move_y_set
update_ball_move_y_invert:
        neg bx
        mov [BallYS], bx
update_ball_move_y_set:
        mov [BallY], ax
update_ball_move_y_end:
update_ball_move_end:
update_ball_end:


draw: ;-------------------------------------------------------------------------
        call clear

draw_p1:
        mov dx, P1H
        mov bx, P1X
        mov cl, P1C
draw_p1_loop:
        mov ax, [P1Y]
        add ax, dx
        call plot
        dec dx                          ; FIXME: Use loop
        jnz draw_p1_loop

draw_p2:
        mov dx, P2H
        mov bx, P2X
        mov cl, P2C
draw_p2_loop:
        mov ax, [P2Y]
        add ax, dx
        call plot
        dec dx                          ; FIXME: Use loop
        jnz draw_p2_loop

draw_ball:
        mov ax, [BallY]
        mov bx, [BallX]
        mov cl, BALL_C
        call plot


spin: ;-------------------------------------------------------------------------
        times SPINLOOP call sleep
        jmp loop
