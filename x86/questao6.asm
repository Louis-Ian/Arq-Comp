org 0x7c00
bits 16

mov ax, 0
mov ds, ax

cli

mov ax, 1 ; inicializa registrador ax com 1 - primeiro valor da sequência de fibonacci 
mov bx, 1 ; inicializa registrador ax com 1 - segundo valor da sequência de fibonacci
mov cx, 2 ; inicializa registrador cx com 2 - terceiro valor da sequência de fibonacci

mov dl, 0 ; dl servirá para controlar o loop que calcula cada termo de fibonacci

loop:

call printi ; subrotina para imprimir cada dígito de um número inteiro positivo 

mov ah, 0x0e ; as linhas 19, 20, 21 
mov al, 32
int 0x10

mov ax, bx ;  as linhas 23, 24, 25 são para fazer o cálculo de fibonacci. Estamos usando a versão x porque precisamos de 16 bits para calcular os 22 termos.
mov bx, cx 
add cx, ax

inc dl 
cmp dl, 22 ; quando tiver impresso os 22 termos de fibonacci, encerra o programa
je fim
jmp loop


printi: 
	push bx ; as linhas 34, 35 e 36 empilhas os valores que estão em bx, cx, dx, já que eles serão usados nesta subrotina
	push cx
	push dx
	;mov si, ax
	;mov ax, [0x7e00]
	mov bx, 10 
	mov cx, 0 ; este registrador servirá para controlar a quantidade de dígitos em um número 
loop2:	mov dx, 0     ;loop para extrair cada dÃ­gito, colocando na pilha
	idiv bx   ; idiv faz a divisão ax:bx, guardando o quociente em ax e o resto da divisão em dx
	
	add dx, 48    ;calcula o caractere correspondente ao dÃ­gito (registrador dx guarda resto da divisÃ£o)
	push dx       ;empilha caractere correspondente 
	inc cx
	or ax, ax
	jnz loop2
loop3:	pop ax        ;loop para desempilhar dí­gitos, escrevendo-os na ordem correta
	mov ah, 0x0e    
	int 0x10
	dec cx
	or cx, cx
	jnz loop3
	pop dx
	pop cx
	pop bx
	ret


fim: hlt


times 510 -($-$$) db 0
dw 0xaa55