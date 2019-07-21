update_player_input:
        in al, KEYBOARD_PORT            ; Read keyboard directly
        cmp al, KEY_W                   ; Up
        je update_player_move_up
        cmp al, KEY_S                   ; Down
        je update_player_move_down
        jmp update_player_move_end      ; Still
update_player_move_up:
        mov ax, [p1_y]                  ; Top of paddle
        cmp ax, 0                       ; Top of screen collision
        je update_player_move_end
        dec word [p1_y]                 ; Move up
        jmp update_player_move_end
update_player_move_down:
        mov ax, [p1_y]                  ; Top of paddle
        add ax, P1_H                    ; Add size of paddle
        cmp ax, SCREEN_H                ; Bottom of screen collision
        je update_player_move_end
        inc word [p1_y]                 ; Move down
update_player_move_end:


update_ai:
        mov cx, [p2_y]                  ; Check ball position
        cmp cx, [ball_y]                ; Top of right paddle
        jg update_ai_move_up            ; Paddle too low
        add cx, P2_H
        cmp cx, [ball_y]                ; Bottom of right paddle
        jl update_ai_move_down          ; Paddle too high
        jmp update_ai_end
update_ai_move_up:
        dec word [p2_y]
        jmp update_ai_end
update_ai_move_down:
        inc word [p2_y]
update_ai_end:


update_ball_x:
        mov ax, [ball_x]
        mov bx, [ball_xs]
        add ax, bx                      ; Calculate next position
update_ball_x_screen_collision:
        jz state_p2_scored              ; Left of screen collision - Win
        cmp ax, SCREEN_W
        je state_p1_scored              ; Right of screen collision - Win
update_ball_x_p1_collision:
        cmp ax, P1_X                    ; Left paddle collision
        jne update_ball_x_p2_collision
        mov cx, [p1_y]
        cmp cx, [ball_y]                ; Top of left paddle collision
        jg update_ball_x_p2_collision
        add cx, P1_H
        cmp cx, [ball_y]                ; Bottom of left paddle collision
        jge update_ball_x_invert
update_ball_x_p2_collision:
        cmp ax, P2_X                    ; Right paddle collision
        jne update_ball_x_apply
        mov cx, [p2_y]
        cmp cx, [ball_y]                ; Top of right paddle collision
        jg update_ball_x_apply
        add cx, P2_H
        cmp cx, [ball_y]                ; Bottom of right paddle collision
        jl update_ball_x_apply
update_ball_x_invert:
        neg bx                          ; Invert direction
        mov [ball_xs], bx
update_ball_x_apply:
        mov [ball_x], ax                ; Apply speed
update_ball_x_end:


update_ball_y:
        mov ax, [ball_y]
        mov bx, [ball_ys]
        add ax, bx                      ; Top of screen collision
        jz update_ball_y_invert
        cmp ax, SCREEN_H                ; Bottom of screen collision
        jne update_ball_y_apply
update_ball_y_invert:
        neg bx                          ; Invert direction
        mov [ball_ys], bx
update_ball_y_apply:
        mov [ball_y], ax                ; Apply speed
update_ball_y_end:
