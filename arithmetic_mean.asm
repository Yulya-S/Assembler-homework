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

	mov	rbx, 0
	mov	rcx, 7

	mov rax, 4
	mul rcx
	mov rcx, rax
M1:
	mov rax, x[rbx]
	sub rax, y[rbx]
	mov arr[rbx], rax
	add rbx, 4
	cmp rbx, rcx
	jne M1

	mov	rbx, 0
	mov rax, 0
M2:
	add rax, arr[rbx]
	add rbx, 4
	cmp rbx, rcx
	jne M2

	mov rbx, rax
	mov rax, rcx
	mov rcx, 4
	div rcx
	mov rcx, rax
	mov rax, rbx

	cmp rax, 0
	jg more
	jmp less

less:
	mov rbx, rcx
	mov rcx, -1
	mul rcx
	mov rax, 7
	mov rcx, rbx
	mov rbx, 0
	mov rdx, 0
	div rcx
	mov rcx, -1
	mul rcx
	jmp finish

more:
	mov rdx, 1
	div rcx

finish:
	print format, rax

	mov rax, 60
	xor rdi, rdi
	syscall

section .data
	format db "%d", 10, 0
	x dd 5, 3, 2, 6, 1, 7, 4
	y dd 0, 10, 1, 9, 2, 8, 5
	arr dd 7 dup(0)

	msg db 'the arithmetic mean of the difference is: ', 0xA, 0xD
	len equ $ - msg
