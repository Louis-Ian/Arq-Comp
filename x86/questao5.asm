org 0x7c00
bits 16

mov ax, 0
mov ds, ax

cli

;as próximas duas linhas são para colocar no modo gráfico
mov al, 0x13
int 0x10

loop1:
; 0x16 é a interrupção de teclado, 0x00 é a função de 'pegar' a tecla digitada e guardá-la em AL
mov ah, 0x00
int 0x16

; nas linhas seguintes, a gente pega o caractere que está em al e o copia para todas as posições da memória ram da placa de vídeo
mov bx, 0xA000
mov es, bx
mov di, 0

loop:
mov [es:di], al
inc di
cmp di, 64000 ;quando todos pixels já estiverem pintados, volte para o início
je loop1
jmp loop ;caso contrário, volte para loop



times 510 - ($-$$) db 0
dw 0xaa55