1 	; 编译链接方法
2 	; (ld 的‘-s’选项意为“strip all”)
3 	;
4 	; $ nasm -f elf hello.asm -o hello.o
5 	; $ ld -s hello.o -o hello
6 	; $ ./hello
7 	; Hello, world!
8 	; $
9 
10	[section .data]	; 数据在此
11
12	strHello	db	"Hello, world!", 0Ah
13	STRLEN		equ	$ - strHello
14
15	[section .text]	; 代码在此
16
17	global _start	; 我们必须导出 _start 这个入口，以便让链接器识别
18
19	_start:
20		mov	edx, STRLEN
21		mov	ecx, strHello
22		mov	ebx, 1
23		mov	eax, 4		; sys_write
24		int	0x80		; 系统调用
25		mov	ebx, 0
26		mov	eax, 1		; sys_exit
27		int	0x80		; 系统调用
28