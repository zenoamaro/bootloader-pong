Keyboard:
  .port         equ 0x60
  .w            equ 0x11
  .s            equ 0x1F

Screen:
  .frame_delay  equ 10
  .addr         equ 0A000h
  .w            equ 320
  .h            equ 200
  .c            equ 0

Ball:
  .x0           equ Screen.w / 2
  .y0           equ Screen.h / 2
  .x            dw .x0
  .y            dw .y0
  .xs           dw 1
  .ys           dw 1
  .c            equ 15

P1:
  .x            equ 23
  .y            dw (Screen.h - .h) / 2
  .h            equ 25
  .c            equ 12
  .score.v      db 0
  .score.x      equ 1
  .score.y      equ 1
  .score.c      equ 4

P2:
  .h            equ 25
  .x            equ Screen.w - 23
  .c            equ 9
  .y            dw (Screen.h - .h) / 2
  .score.v      db 0
  .score.x      equ 38
  .score.y      equ 1
  .score.c      equ 1

GameOver:
  .s            db "GAME OVER!"
  .l            equ $ - .s
  .x            equ (40 - .l) / 2
  .y            equ 24 / 2
  .c            equ 10
  .score        equ 10
