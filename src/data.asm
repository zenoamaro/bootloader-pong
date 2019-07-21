VIDEO           equ 0A000h
SPINLOOP        equ 10

KEYBOARD_PORT   equ 0x60
KEY_W           equ 0x11
KEY_S           equ 0x1F

SCREEN_W        equ 320
SCREEN_H        equ 200
BG_C            equ 0

BALL_X_START    equ SCREEN_W / 2
BALL_Y_START    equ SCREEN_H / 2
BallX           dw BALL_X_START
BallY           dw BALL_Y_START
BallXS          dw 1
BallYS          dw 1
BALL_C          equ 15

P1H             equ 25
P1X             equ 10
P1Y             dw (SCREEN_H-P1H) / 2
P1C             equ 2

P2H             equ 25
P2X             equ SCREEN_W - 10
P2Y             dw (SCREEN_H-P2H) / 2
P2C             equ 2
