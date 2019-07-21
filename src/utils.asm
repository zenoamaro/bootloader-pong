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
