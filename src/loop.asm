loop: ;-------------------------------------------------------------------------


update: ;-----------------------------------------------------------------------

update_player_input:
        in al, KEYBOARD_PORT            ; Read keyboard directly
        cmp al, KEY_W                   ; Up
        je update_player_move_up
        cmp al, KEY_S                   ; Down
        je update_player_move_down
        jmp update_player_move_end      ; Still
update_player_move_up:
        mov ax, [P1Y]                   ; Top of paddle
        cmp ax, 0                       ; Top of screen collision
        je update_player_move_end
        dec word [P1Y]                  ; Move up
        jmp update_player_move_end
update_player_move_down:
        mov ax, [P1Y]                   ; Top of paddle
        add ax, P1H                     ; Add size of paddle
        cmp ax, SCREEN_H                ; Bottom of screen collision
        je update_player_move_end
        inc word [P1Y]                  ; Move down
update_player_move_end:


update_ball_move_x:
        mov ax, [BallX]
        mov bx, [BallXS]
        add ax, bx
        jz update_ball_move_x_invert    ; Left of screen collision
        cmp ax, SCREEN_W                ; Right of screen collision
        jne update_ball_move_x_set
update_ball_move_x_invert:
        neg bx                          ; Invert direction
        mov [BallXS], bx
update_ball_move_x_set:
        mov [BallX], ax                 ; Apply speed
update_ball_move_x_end:

update_ball_move_y:
        mov ax, [BallY]
        mov bx, [BallYS]
        add ax, bx
        jz update_ball_move_y_invert
        cmp ax, SCREEN_H                ; Bottom of screen collision
        jne update_ball_move_y_set
update_ball_move_y_invert:
        neg bx                          ; Invert direction
        mov [BallYS], bx
update_ball_move_y_set:
        mov [BallY], ax                 ; Apply speed
update_ball_move_y_end:


draw: ;-------------------------------------------------------------------------
        call clear                      ; Clear the screen

draw_p1:
        mov dx, P1H                     ; Size of paddle
        mov bx, P1X
        mov cl, P1C
draw_p1_loop:
        mov ax, [P1Y]                   ; Top of paddle
        add ax, dx
        dec ax                          ; Inclusive zero loop
        call plot
        dec dx                          ; FIXME: Use loop
        jnz draw_p1_loop                ; Loop to size of paddle

draw_p2:
        mov dx, P2H                     ; Size of paddle
        mov bx, P2X
        mov cl, P2C
draw_p2_loop:
        mov ax, [P2Y]                   ; Top of paddle
        add ax, dx
        dec ax                          ; Inclusive zero loop
        call plot
        dec dx                          ; FIXME: Use loop
        jnz draw_p2_loop                ; Loop to size of paddle

draw_ball:
        mov ax, [BallY]
        mov bx, [BallX]
        mov cl, BALL_C
        call plot


spin: ;-------------------------------------------------------------------------
        times SPINLOOP call sleep       ; FIXME: Proper timestep
        jmp loop
