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
        cmp al, Keyboard.space          ; Don't draw spaces
        je .end
        mov bh, 0                       ; Page zero
        push ax
        push bx
        mov ax, 0200h                   ; Move cursor
        int 10h
        pop bx
        pop ax
        mov ah, 0Ah                     ; Plot char
        mov cx, 1                       ; Repeat once
        int 10h
  .end:
        ret

Sleep:
        ; No args
        mov ah, 86h
        mov cx, 0
        mov dx, Screen.frame_delay
        int 15h
        ret
