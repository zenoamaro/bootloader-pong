plot:
        ; ax=y, bx=x, cl=color
        imul ax, 320
        add ax, bx
        mov di, ax
        mov [es:di], cl
        ret

cls:
        ; cl=color
        mov di, SCREEN_W * SCREEN_H
cls_loop:
        mov [es:di], cl
        dec di
        jnz cls_loop
        ret

plotc:
        ; al=char bl=color dl=x dh=y
        mov bh, 0                      ; Page zero
        push ax
        push bx
        mov ax, 0x0200                  ; Move cursor
        int 10h
        pop bx
        pop ax
        mov ah, 0x0A                    ; Plot char
        mov cx, 1                       ; Repeat once
        int 10h
        ret

sleep:
        mov edx, SPINLOOPS
sleep_loop:
        mov ecx, 0xffffffff
sleep_inner:
        loop sleep_inner
        dec edx
        jnz sleep_loop
        ret
