%macro pushd 0
	push rdx
	push rcx
	push rbx
	push rax
%endmacro

%macro popd 0
	pop rax
	pop rbx
	pop rcx
	pop rdx
%endmacro

%macro print 2
	pushd
	push rbp
	mov rdi, %1
	mov rsi, %2
	call printf
	pop rbp
	popd
%endmacro


section .text
global main

extern printf

main:
	mov		rax, 1
	mov		rdi, 1
	mov		rsi, msg
	mov		rdx, len
	syscall

	; x1 = num / 2

	mov rax, [number]
	mov rcx, 2
	mov rdx, 0
	div rcx

m1:

	; (x1 + (num / x1)) // 2

	mov rcx, rax
	mov rax, [number]

	mov rdx, 0
	div rcx
	
	add rax, rcx

	mov rbx, 2
	mov rdx, 0
	div rbx

	sub rcx, rax

	cmp rcx, 1
	jge m1

ex:
	print format, rax

	mov rax, 60
	xor rdi, rdi
	syscall

section .data
	format db "%d", 10, 0

	number dq 25

	msg db 'The square root is: ', 0xA, 0xD
	len equ $ - msg