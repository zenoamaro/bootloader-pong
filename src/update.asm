update_player:
    .input:
        in al, Keyboard.port            ; Read keyboard directly
        cmp al, Keyboard.w              ; Up
        je .move_up
        cmp al, Keyboard.s              ; Down
        je .move_down
        jmp .end                        ; Still
    .move_up:
        mov ax, [P1.y]                  ; Top of paddle
        cmp ax, 0                       ; Top of screen collision
        je .end
        dec word [P1.y]                 ; Move up
        jmp .end
    .move_down:
        mov ax, [P1.y]                  ; Top of paddle
        add ax, P1.h                    ; Add size of paddle
        cmp ax, Screen.h                ; Bottom of screen collision
        je .end
        inc word [P1.y]                 ; Move down
    .end:

update_ai:
    .think:
        mov cx, [Ball.x]                ; Only move if ball is within reach
        cmp cx, P2.ai_reach
        jle .end
        mov cx, [P2.y]                  ; Compare to ball position
        cmp cx, [Ball.y]                ; Top of right paddle
        jg .move_up                     ; Paddle too low
        add cx, P2.h
        cmp cx, [Ball.y]                ; Bottom of right paddle
        jl .move_down                   ; Paddle too high
        jmp .end
    .move_up:
        dec word [P2.y]
        jmp .end
    .move_down:
        inc word [P2.y]
    .end:

update_ball_x:
        mov ax, [Ball.x]
        mov bx, [Ball.xs]
        add ax, bx                      ; Calculate next position
    .collide_screen_left:
        jnz .collide_screen_right       ; Left of screen collision - Win
        inc byte [P2.score.v]           ; Inc score
        cmp [P2.score.v], byte Match.max_score
        jge game_over                   ; Game over
        jmp match_start                 ; Restart match
    .collide_screen_right:
        cmp ax, Screen.w
        jne .collide_p1                 ; Right of screen collision - Win
        inc byte [P1.score.v]           ; Inc score
        cmp [P1.score.v], byte Match.max_score
        jge game_over                   ; Game over
        jmp match_start                 ; Restart match
    .collide_p1:
        cmp ax, P1.x                    ; Left paddle collision
        jne .collide_p2
        mov cx, [P1.y]
        cmp cx, [Ball.y]                ; Top of left paddle collision
        jg .collide_p2
        add cx, P1.h
        cmp cx, [Ball.y]                ; Bottom of left paddle collision
        jge .bounce
    .collide_p2:
        cmp ax, P2.x                    ; Right paddle collision
        jne .apply
        mov cx, [P2.y]
        cmp cx, [Ball.y]                ; Top of right paddle collision
        jg .apply
        add cx, P2.h
        cmp cx, [Ball.y]                ; Bottom of right paddle collision
        jl .apply
    .bounce:
        neg bx                          ; Invert direction
        mov [Ball.xs], bx
    .apply:
        mov [Ball.x], ax                ; Apply speed
    .end:

update_ball:
        mov ax, [Ball.y]
        mov bx, [Ball.ys]
        add ax, bx                      ; Top of screen collision
        jz .bounce
        cmp ax, Screen.h                ; Bottom of screen collision
        jne .apply
    .bounce:
        neg bx                          ; Invert direction
        mov [Ball.ys], bx
    .apply:
        mov [Ball.y], ax                ; Apply speed
    .end:
