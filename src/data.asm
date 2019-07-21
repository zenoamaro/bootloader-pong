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
P1X             equ 23
P1Y             dw (SCREEN_H-P1H) / 2
P1C             equ 12
P1Score         db 0
P1_SCORE_C      equ 4
P1_SCORE_X      equ 1
P1_SCORE_Y      equ 1

P2H             equ 25
P2X             equ SCREEN_W - 23
P2Y             dw (SCREEN_H-P2H) / 2
P2C             equ 9
P2Score         db 0
P2_SCORE_C      equ 1
P2_SCORE_X      equ 38
P2_SCORE_Y      equ 1
