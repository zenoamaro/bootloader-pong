SPINLOOPS       equ 10

VIDEO           equ 0A000h
SCREEN_W        equ 320
SCREEN_H        equ 200
BG_C            equ 0

KEYBOARD_PORT   equ 0x60
KEY_W           equ 0x11
KEY_S           equ 0x1F

BALL_START_X    equ SCREEN_W / 2
BALL_START_Y    equ SCREEN_H / 2
ball_x          dw BALL_START_X
ball_y          dw BALL_START_Y
ball_xs         dw 1
ball_ys         dw 1
BALL_C          equ 15

P1_H            equ 25
P1_X            equ 23
P1_C            equ 12
p1_y            dw (SCREEN_H-P1_H) / 2
P1_SCORE_C      equ 4
P1_SCORE_X      equ 1
P1_SCORE_Y      equ 1
p1_score        db 0

P2_H            equ 25
P2_X            equ SCREEN_W - 23
P2_C            equ 9
p2_y            dw (SCREEN_H-P2_H) / 2
P2_SCORE_C      equ 1
P2_SCORE_X      equ 38
P2_SCORE_Y      equ 1
p2_score        db 0

MAX_SCORE       equ 10

game_over_s     db "GAME OVER!"
GAME_OVER_L     equ 10
GAME_OVER_X     equ (40-GAME_OVER_L) / 2
GAME_OVER_Y     equ 24 / 2
GAME_OVER_C     equ 10
