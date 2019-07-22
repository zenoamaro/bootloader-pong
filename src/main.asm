        org 7C00h                       ; Bootloader

main:
        %include "src/setup.asm"
        %include "src/loop.asm"
        %include "src/utils.asm"

data:
        %include "src/data.asm"

padding:
        %assign compiled_size $-$$
        %warning Compiled size: compiled_size bytes

        times 0200h-2-compiled_size  db 0       ; Zerofill up to 510 bytes
        dw 0AA55h                               ; Boot Sector signature
