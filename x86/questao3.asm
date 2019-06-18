org 0x7c00
bits 16

mov ax, 0
mov ds, ax

cli ;limpar interrupção 

push 0 ;to colocando 0 na base da pilha pra identificar ultima posição da pilha

loop:
mov ah, 0x00 ;função de leitura do teclado. tecla digitada vai para o registrador al
int 0x16 ; interrupção de teclado
cmp al, 13 ;13 é o enter
je enter ; se al = 13, pule para label enter
push ax ;vai empilhando as teclas digitadas 

mov ah, 0x0E
int 0x10 
jmp loop

;as três linhas anteriores são para imprimir o que vai sendo digitado

enter: ;imprime quebra de linha 
mov al, 13 ;13 é o enter
mov ah, 0x0E ;função para imprimir caractere que está em AL na tela
int 0x10   
mov al, 10 ;10 é o retorno de linha
int 0x10


imp: ;imprime frase invertida
pop ax ;retira valor do topo da pilha e guarda em ax
cmp ax, 0
je fim
mov ah, 0x0E
int 0x10
jmp imp

fim: hlt

times 510 -($-$$) db 0
dw 0xaa55





