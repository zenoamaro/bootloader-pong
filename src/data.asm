SPINLOOP        equ 10
SCREEN_W        equ 320
SCREEN_H        equ 200
BG_C            equ 0

BallX           dw SCREEN_W / 2
BallY           dw SCREEN_H / 2
BallXS          dw 1
BallYS          dw 1
BALL_C          equ 15

P1H             equ 40
P1X             equ 10
P1Y             dw (SCREEN_H-P1H) / 2
P1YS            dw 0
P1C             equ 2

P2H             equ 40
P2X             equ SCREEN_W - 10
P2Y             dw (SCREEN_H-P1H) / 2
P2YS            dw 0
P2C             equ 2
