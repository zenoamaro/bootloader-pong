        org 7C00h                       ; Bootloader
        jmp start

data:
        %include "src/data.asm"

start:
        %include "src/setup.asm"
        %include "src/loop.asm"
        %include "src/utils.asm"

padding:
        times 0200h-2-($-$$)  db 0      ; Zerofill up to 510 bytes
        dw 0AA55h                       ; Boot Sector signature
