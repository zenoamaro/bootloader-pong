loop: ;-------------------------------------------------------------------------


clean: ;------------------------------------------------------------------------
        mov ax, [BallY]
        mov bx, [BallX]
        mov cl, BG_C
        call plot


update: ;-----------------------------------------------------------------------

update_x:
        mov ax, [BallX]
        mov bx, [BallXS]
        add ax, bx
        jz invert_x
        cmp ax, SCREEN_W
        jne set_x
invert_x:
        neg bx
        mov [BallXS], bx
set_x:
        mov [BallX], ax

update_y:
        mov ax, [BallY]
        mov bx, [BallYS]
        add ax, bx
        jz invert_y
        cmp ax, SCREEN_H
        jne set_y
invert_y:
        neg bx
        mov [BallYS], bx
set_y:
        mov [BallY], ax


draw: ;-------------------------------------------------------------------------

draw_ball:
        mov ax, [BallY]
        mov bx, [BallX]
        mov cl, BALL_C
        call plot


spin: ;-------------------------------------------------------------------------
        times SPINLOOP call sleep
        jmp loop
