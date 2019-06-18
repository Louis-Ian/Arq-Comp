org 0x7c00
bits 16

mov ax, 0
mov ds, ax

cli
;as duas linhas a seguir colocam no modo gráfico, necessário para 'pintar' os pixels da tela
mov al, 0x13
int 0x10
;A000 é o primeiro endereço da região da placa vídeo onde devem ser colocados os bytes que indicam a cor de cada pixel da tela. 
mov ax, 0xA000
mov es, ax
mov di, 0

mov cx, 0 ;em cx estarão guardados os números que serão postos na memória ram da placa vídeo
mov bx, 1 ; bx indica em qual iteração está o loop. isto é necessário para dar o efeito animado, como fala o professor na última dica desta questão

;neste loop, estamos colocando números consecutivos em posições consecutivas da memória ram da placa vídeo. 
loop:
mov [es:di], cx
inc cx
inc di
cmp di, 64000 ; 320x200, que é a resolução do modo gráfico, é igual a 64000. Quando chegar a este valor, significa que toda a tela já foi pintada
je restart
jmp loop


;quando toda a tela é pintada, voltamos ao novamente ao primeiro pixel. Se a primeira cor na i-ésima iteração era x, na i+1-ésima iteração será x+1. Isto está sendo controlado pelo registrador bx
restart:
mov di, 0
mov cx, bx
inc bx
jmp loop


times 510 - ($-$$) db 0
dw 0xaa55