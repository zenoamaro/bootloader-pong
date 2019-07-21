match_start:
        neg word [Ball.xs]              ; Invert horizontal direction
        mov [Ball.x], word Ball.x0      ; Ball at starting position
        mov [Ball.y], word Ball.y0

game_loop:
        %include "src/update.asm"
        %include "src/draw.asm"

game_spin:
        mov ah, 86h                     ; Elapsed time wait call
        mov cx, 0                       ; Delay
        mov dx, Screen.frame_delay      ; Delay
        int 15h                         ; System BIOS call
        jmp game_loop

game_over:
        mov di, GameOver.s              ; String pointer
        mov cx, GameOver.l              ; String index from end
        mov dl, GameOver.x              ; X
        mov dh, GameOver.y              ; Y
        mov bl, GameOver.c              ; Color
    .print:
        mov al, [di]                    ; Get actual char
        push cx
        call PlotChar                   ; Plot char
        inc dl                          ; One x forward
        inc di                          ; One char forward
        pop cx
        loop .print                     ; Loop until string end
    .spin:
        jmp .spin                       ; Spin forever
