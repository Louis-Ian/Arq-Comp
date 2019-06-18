org 0x7c00
bits 16

mov ax, 0
mov ds, ax


cli

mov bx, 0

;neste loop, pegamos as teclas digitadas pelo usuário, usando a interrupção 16, e a exibimos usando a interrupção. além disso, convertemos o caractere em um número inteiro no trecho 'converte'

loop:
mov ah, 0x00
int 0x16
cmp al, 13 ;quando usuário apertar enter, pule para a parte em que se verifica se o número entrado é primo ou não
je primo
mov ah, 0x0e
int 0x10 ;linhas 19 e 20 são para exibir o caractere, que está no registrador al, na tela.
jmp converte ;pule para trecho do código em que o caractere é convertido em um número inteiro
;jmp loop


converte:
;mov ax, 0
sub al, 48 ;subtraímos 48 de al porque o caractere 0 corresponde ao número 48 na tabela ASCII
imul bx, 10 ;multiplicamos o valor que está em bx por 10
add bl, al ;somamos al e bl, guardando o resultado em bl. Isto é feito para que, se o usuário digitar, por exemplo, o caractere 1 seguido do 5, fique guardado em bl o número 15 inteiro
;ret
jmp loop

;este trecho do código verifica se um dado número, que está guardado em bl, é ou não primo
primo:
push bx
mov ax, 0
mov cx, 0
mov dx, 0
mov bx, 0
pop bx


;as linhas anteriores, por algum motivo que eu não sei explicar, são necessárias para que o comando div funcione adequadamente aqui.

mov cx, 2 ;cx começa com dois. a cada iteração, ele aumenta uma unidade. se a divisão ax=bx:cx tiver resto 0, então retorne NÃO PRIMO; senão, se cx = bx, então retorne primo
lp:cmp cx, bx
je afirmativo
mov ax, bx
mov dx, 0
div cx
or dx, dx
jz negativo
inc cx
jmp lp





;trecho para imprimir na tela a mensagem de que o número digitado é primo
afirmativo:
mov si, msg1
mov ah, 0x0e
volta:lodsb
cmp al, 0
je fim
int 0x10
jmp volta


;trecho para imprimir na tela a mensagem de que o número digitado não é primo
negativo:
mov si, msg2
mov ah, 0x0e
volta2:lodsb
cmp al, 0
je fim
int 0x10
jmp volta2



fim: hlt



msg1: db ' Eh primo!', 0
msg2: db  ' Nao eh primo!', 0

times 510 - ($-$$) db 0
dw 0xaa55