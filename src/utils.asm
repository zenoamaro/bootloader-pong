plot:
        ; ax=y, bx=x, cl=color
        imul ax, 320
        add ax, bx
        mov di, ax
        mov [es:di], cl
        ret

clear:
        ; cl=color
        mov di, SCREEN_W * SCREEN_H
clear_loop:
        mov [es:di], cl
        dec di
        jnz clear_loop
        ret

sleep:
        mov ecx, 0xffffffff
sleep_loop:
        loop sleep_loop
        ret
