init: ;-------------------------------------------------------------------------
        neg word [BallXS]               ; Invert horizontal direction
        mov [BallX], word BALL_X_START  ; Ball at starting position
        mov [BallY], word BALL_Y_START


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


update_ai:
        mov cx, [P2Y]                   ; Check ball position
        cmp cx, [BallY]                 ; Top of right paddle
        jg update_ai_move_up            ; Paddle too low
        add cx, P2H
        cmp cx, [BallY]                 ; Bottom of right paddle
        jl update_ai_move_down          ; Paddle too high
        jmp update_ai_end
update_ai_move_up:
        dec word [P2Y]
        jmp update_ai_end
update_ai_move_down:
        inc word [P2Y]
update_ai_end:


update_ball_x:
        mov ax, [BallX]
        mov bx, [BallXS]
        add ax, bx                      ; Calculate next position
update_ball_x_screen_collision:
        jz state_p2_scored                 ; Left of screen collision - Win
        cmp ax, SCREEN_W
        je state_p1_scored                 ; Right of screen collision - Win
update_ball_x_p1_collision:
        cmp ax, P1X                     ; Left paddle collision
        jne update_ball_x_p2_collision
        mov cx, [P1Y]
        cmp cx, [BallY]                 ; Top of left paddle collision
        jg update_ball_x_p2_collision
        add cx, P1H
        cmp cx, [BallY]                 ; Bottom of left paddle collision
        jge update_ball_x_invert
update_ball_x_p2_collision:
        cmp ax, P2X                     ; Right paddle collision
        jne update_ball_x_apply
        mov cx, [P2Y]
        cmp cx, [BallY]                 ; Top of right paddle collision
        jg update_ball_x_apply
        add cx, P2H
        cmp cx, [BallY]                 ; Bottom of right paddle collision
        jl update_ball_x_apply
update_ball_x_invert:
        neg bx                          ; Invert direction
        mov [BallXS], bx
update_ball_x_apply:
        mov [BallX], ax                 ; Apply speed
update_ball_x_end:


update_ball_y:
        mov ax, [BallY]
        mov bx, [BallYS]
        add ax, bx                      ; Top of screen collision
        jz update_ball_y_invert
        cmp ax, SCREEN_H                ; Bottom of screen collision
        jne update_ball_y_apply
update_ball_y_invert:
        neg bx                          ; Invert direction
        mov [BallYS], bx
update_ball_y_apply:
        mov [BallY], ax                 ; Apply speed
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
        mov al, [P1Score]
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
        mov al, [P2Score]
        add al, 48                      ; `0` character
        mov cx, 1                       ; Repeat once
        mov bl, P2_SCORE_C              ; Color
        int 10h

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
        call sleep                      ; FIXME: Proper timestep
        jmp loop


states: ;-----------------------------------------------------------------------

state_p1_scored:
        inc byte [P1Score]
        cmp [P1Score], byte MAX_SCORE
        jge state_game_over
        jmp init
state_p2_scored:
        inc byte [P2Score]
        cmp [P2Score], byte MAX_SCORE
        jge state_game_over
        jmp init

state_game_over:
        jmp state_game_over
