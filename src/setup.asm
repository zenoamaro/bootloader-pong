        mov ax, 13h                     ; Set video mode 13h
        int 10h

        mov ax, VIDEO                   ; Offset to video memory
        mov es, ax
