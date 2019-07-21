plot:
        ; ax=y, bx=x, cl=color
        imul ax, 320
        add ax, bx
        mov di, ax
        mov [es:di], cl
        ret

sleep:
        mov ecx, 0xffffffff
sleep_loop:
        loop sleep_loop
        ret
