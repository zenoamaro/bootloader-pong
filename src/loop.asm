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
