clear_screen:
        mov cl, Screen.c                ; Clear screen to bg color
        mov di, Screen.w * Screen.h
    .loop:
        mov [es:di], cl
        dec di
        jnz .loop

draw_net:
        mov ax, Net.y                   ; Y
        mov bx, Net.x                   ; X
        mov cx, Net.h                   ; Height
        mov dl, Net.c                   ; Color
    .loop:
        call Plot                       ; Plot
        add ax, 2                       ; Dotted line
        loop .loop                      ; Loop to height of net

draw_scores:
    .p1:
        mov dl, P1.score.x              ; X
        mov dh, P1.score.y              ; Y
        mov bl, P1.score.c              ; Color
        mov al, [P1.score.v]            ; Score value
        add al, 48                      ; Shift to `0` character
        call PlotChar                   ; Plot char
    .p2:
        mov dl, P2.score.x              ; X
        mov dh, P2.score.y              ; Y
        mov bl, P2.score.c              ; Color
        mov al, [P2.score.v]            ; Score value
        add al, 48                      ; Shift to `0` character
        call PlotChar                   ; Plot char

draw_p1:
        mov ax, [P1.y]                  ; Y
        mov bx, P1.x                    ; X
        mov cx, P1.h                    ; Height
        mov dl, P1.c                    ; Color
    .loop:
        call Plot                       ; Plot
        inc ax                          ; Next row
        loop .loop                      ; Loop to size of paddle

draw_p2:
        mov ax, [P2.y]                  ; Y
        mov bx, P2.x                    ; X
        mov cx, P2.h                    ; Height
        mov dl, P2.c                    ; Color
    .loop:
        call Plot                       ; Plot
        inc ax                          ; Next row
        loop .loop                      ; Loop to size of paddle

draw_ball:
        mov ax, [Ball.y]                ; Y
        mov bx, [Ball.x]                ; X
        mov dl, Ball.c                  ; Color
        call Plot                       ; Plot
