setup_video_mode:
        mov ax, 13h                     ; 320 x 200 x 8
        int 10h

setup_memory_offset:
        mov ax, Screen.addr
        mov es, ax
