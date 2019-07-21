init: ;-------------------------------------------------------------------------
        neg word [ball_xs]              ; Invert horizontal direction
        mov [ball_x], word BALL_START_X ; Ball at starting position
        mov [ball_y], word BALL_START_Y


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


draw: ;-------------------------------------------------------------------------
        mov cx, BG_C                    ; Clear the screen to bg color
        call clear

draw_p1_score:
        mov ebx, 0                      ; Page zero
        mov ax, 0x0200                  ; Move cursor
        mov dl, P1_SCORE_X
        mov dh, P1_SCORE_Y
        int 10h
        mov ah, 0x0A                    ; Print char
        mov al, [p1_score]
        add al, 48                      ; `0` character
        mov cx, 1                       ; Repeat once
        mov bl, P1_SCORE_C              ; Color
        int 10h
draw_p2_score:
        mov ebx, 0                      ; Page zero
        mov ax, 0x0200                  ; Move cursor
        mov dl, P2_SCORE_X
        mov dh, P2_SCORE_Y
        int 10h
        mov ah, 0x0A                    ; Print char
        mov al, [p2_score]
        add al, 48                      ; `0` character
        mov cx, 1                       ; Repeat once
        mov bl, P2_SCORE_C              ; Color
        int 10h

draw_p1:
        mov dx, P1_H                    ; Size of paddle
        mov bx, P1_X
        mov cl, P1_C
draw_p1_loop:
        mov ax, [p1_y]                  ; Top of paddle
        add ax, dx
        dec ax                          ; Inclusive zero loop
        call plot
        dec dx                          ; FIXME: Use loop
        jnz draw_p1_loop                ; Loop to size of paddle

draw_p2:
        mov dx, P2_H                    ; Size of paddle
        mov bx, P2_X
        mov cl, P2_C
draw_p2_loop:
        mov ax, [p2_y]                  ; Top of paddle
        add ax, dx
        dec ax                          ; Inclusive zero loop
        call plot
        dec dx                          ; FIXME: Use loop
        jnz draw_p2_loop                ; Loop to size of paddle

draw_ball:
        mov ax, [ball_y]
        mov bx, [ball_x]
        mov cl, BALL_C
        call plot


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
state_game_over_print:
        mov ebx, 0                      ; Page zero
        mov ax, 0x0200                  ; Move cursor
        mov dl, GAME_OVER_X
        mov dh, GAME_OVER_Y
        add dl, cl-1                    ; Offset x by index
        int 10h
        mov bx, game_over_s             ; Pointer to string
        add bx, cx                      ; Offset by index
        dec bx
        mov di, bx                      ; Address
        mov ax, [di]
        mov ah, 0x0A                    ; Print char
        push cx
        mov cx, 1                       ; Repeat once
        mov ebx, GAME_OVER_C            ; Color
        int 10h
        pop cx
        loop state_game_over_print
state_game_over_spin:
        jmp state_game_over_spin
