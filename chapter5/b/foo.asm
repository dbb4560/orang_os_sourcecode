1 	; 编译链接方法
2 	; (ld 的‘-s’选项意为“strip all”)
3 	;
4 	; $ nasm -f elf foo.asm -o foo.o
5 	; $ gcc -c bar.c -o bar.o
6 	; $ ld -s hello.o bar.o -o foobar
7 	; $ ./foobar
8 	; the 2nd one
9 	; $
10
11	extern choose	; int choose(int a, int b);
12
13	[section .data]	; 数据在此
14
15	num1st		dd	3
16	num2nd		dd	4
17
18	[section .text]	; 代码在此
19
20	global _start	; 我们必须导出 _start 这个入口，以便让链接器识别
21	global myprint	; 导出这个函数为了让 bar.c 使用
22
23	_start:
24		push	dword [num2nd]	; `.
25		push	dword [num1st]	;  |
26		call	choose		;  | choose(num1st, num2nd);
27		add	esp, 8		; /
28
29		mov	ebx, 0
30		mov	eax, 1		; sys_exit
31		int	0x80		; 系统调用
32
33	; void myprint(char* msg, int len)
34	myprint:
35		mov	edx, [esp + 8]	; len
36		mov	ecx, [esp + 4]	; msg
37		mov	ebx, 1
38		mov	eax, 4		; sys_write
39		int	0x80		; 系统调用
40		ret
41		
42