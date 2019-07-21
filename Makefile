dist/pong.img: src/*.asm
	nasm -f bin -o dist/pong.img src/main.asm

run: dist/pong.img
	qemu-system-x86_64 -cpu 486 -drive format=raw,file=dist/pong.img
