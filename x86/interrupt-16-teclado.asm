        ;Programa para saudar o usuário com entrada de string
        org 0x7c00
        bits 16

        mov ax, 0
        mov ds, ax      ; DS = 0

        mov ax, perg    ; AX = &perg
        call prints     ; print(AX) => print(perg)

        mov ax, 0x7e00
        call gets

        mov ax, respi
        call prints

        mov ax, 0x7e00
        call prints

        mov ax, respf
        call prints
        
        jmp fim

        ;Subrotina para pegar uma string digitada (até o enter) usando a interrupção 0x16 (teclado),
        ; gravando as letras no endereço indicado pelo registrador ax
gets:	push ax         ;Salva AX
        push di         ; e DI qna pilha
        mov di, ax      ;DI = AX

.loop2: mov ah, 0 	;laço para gravar cada letra digitada até encontrar o enter
        int 0x16
        cmp al, 13
        je .ret2
        mov [ds:di], al
        inc di
        mov ah, 0x0e
        int 0x10
        jmp .loop2

.ret2:	mov ah, 0x0e 	;finaliza quebrando a linha
        int 0x10
        mov al, 10
        int 0x10
        mov [ds:di], byte 0 	;grava o byte 0 no final da string
        pop di
        pop ax
        ret

        ;Subrotina para escrever na tela a string gravada no endereço indicado pelo registrador ax utilizando a interrupção 0x10 (ví­deo)
prints:	push ax         ;pilha += AX (perg)     ;salva os valores de AX e SI na pilha para recuperar depois
        push si         ;pilha += SI
        mov si, ax      ;SI = AX (perg)
        mov ah, 0x0E    ;Imprime caractere

.loop1:	lodsb			;laço para ler a string escrevendo letra por letra
        or al, al
        jz .ret1
        int 0x10
        jmp .loop1

.ret1:	pop si          ;SI = topoDaPilha
        pop ax          ;AX = topoDaPilha
        ret

fim:	hlt

;strings constantes
perg:	db "Oi! Qual o seu nome?", 10, 13, 0
respi:	db "Ola, ", 0
respf:  db "!", 10 , 13, 0

	times 510 - ($-$$) db 0
	dw 0xaa55