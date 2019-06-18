org 0x7c00
bits 16

mov ax, 0
mov ds, ax

cli

;leitura do arquivo 
int 0x13 ;interrupção de disco

mov ah, 0x02 ; função para ler setores
mov al, 0x01 ; vai ler apenas um setor - porque o arquivo tem apenas 512 bytes (1 setor tem 512 bytes extamente)
mov cl, 0x02 ; ler a partir do setor 2 - o primeiro setor é o setor 1, e é onde está o programa. Portanto, o arquivo com a mensagem criptografada estará no segundo setor, que é o setor 2
mov ch, 0 ; do cabeçote 0
mov bx, 0x7e00 ; primeira região de memório depois dos 512 bytes do programa. É neste endereço em que será colocada a mensagem criptografada

int 0x13

mov dx, 0x7e00 ; dx vai guardar o endereço da mensagem cripotgrafa, que começa a partir do endereço 0x7e00 (foi este endereço que escolhemos na hora da ler o arquivo)
mov cx, mat  ; cx vai guardar o endereço da matrícula, que está indicada pelo label mat, ao fim deste código

loop:

mov si, cx ;coloca em si o endereço que está em cx, que é o endereço de algum byte da matrícula
mov bl, [si] ;joga o valor que está no endereço si no registrador bl
inc si  ;incrementa si; isto significa que si agora vai apontar para o endereço do próximo byte da matrícula
cmp [si], byte 10 ;comparo o valor do novo endereço de si com o byte 10; se for igual, pula para label lb
je lb
cont:mov cx, si ;move novo endereço de si para cx


mov si, dx  ;move endereço que está em dx, que é o endereço de algum byte da mensagem, 
mov al, [ds:si] ;move valor que está nesse endereço de si e move para o registrador al
sub al, bl      ; subtrai valor que está em bl, que é o byte da matrícula, do valor que está em al, que é o byte mensagem, colocando o valor em al

mov ah, 0x0e ;função para exibir caractere na tela (sem ser no modo gráfico, usando interrupção)
int 0x10    ; as linhas 38 e 37 servem para imprimir o caractere que está em al na tela. 
inc si  ;faz si apontar para o próximo byte da mensagem 

cmp [si], byte 0 ;se o valor desse próximo for 0, significa que chegamos ao fim da mensagem, então pule para o fim do programa
je fim
mov dx, si ;mova o novo valor de si, que é o endereço do próximo byte da mensagem, em dx
jmp loop  ;pule para loop, repetindo o processo
;A label a seguir serve para reatribuir a si o valor do primeiro byte de matrícula

lb:
mov si, mat 
jmp cont ;Volta para label cont, que está na linha 30


fim: hlt

mat: db 3, 8, 4, 3, 5, 4, 10

times 510 -($-$$) db 0
dw 0xaa55