ClearScreen:
        ; cl=color
        mov di, Screen.w * Screen.h
  .loop:
        mov [es:di], cl
        dec di
        jnz .loop
        ret

Plot:
        ; ax=y, bx=x, dl=color
        push ax
        imul ax, 320
        add ax, bx
        mov di, ax
        mov [es:di], dl
        pop ax
        ret

PlotChar:
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

Sleep:
        ; No args
        mov edx, Screen.frame_delay
  .outer:
        mov ecx, 0xffffffff
  .inner:
        loop .inner
        dec edx
        jnz .outer
        ret
