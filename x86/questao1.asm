org 0x7c00
bits 16

mov ax, 0
mov ds, ax

cli 

mov al, 0x13 ;coloca no modo gráfico VGA, 320X200 px
int 0x10 ;Interrupção de vídeo. Toda questão pra imprimir algo na tela provavelmente vai ter que ser utilizada a interrupção 0x10


int 0x13 ;Interrupção de disco. Sempre que tiver que ler arquivo, provavelmente usa-se esta interrupção. 

mov ah, 0x02 ;ler setores
mov al, 0x20 ;quantos setores devem ser lidos. 0x20 é 32 em hexadecimal
mov cl, 2    ;ler a partir do setor 2
mov ch, 0    ;do cilindro 0
mov dh, 0    ;do cabeçote 0
mov bx, 0x7e00 ;coloque os dados lidos no end 0x7e00
int 0x13

mov ax, 0xa000 ; endereço da memória ram de vídeo (VRAM)
mov es, ax ; es = extra segment
mov di, 0
mov si, 0x7e00 ; si = source index. source = fonte. é de onde vamos puxar a imagem. lembre-se que a imagem lida está escrita a partir do endereço 0x7e00

loop:
mov al, [ds:si] ; pegue o dado que está no endereço ds:si e copie para al
mov [es:di], al ; pegue o dado que está em al e coloque no endereço es:di
inc di
inc si
cmp di, 16000
je fim 
jmp loop


fim: hlt




times 510 - ($ - $$) db 0
dw 0xaa55
