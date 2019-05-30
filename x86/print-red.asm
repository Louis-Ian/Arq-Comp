    org 0x7c00
    bits 16
    ;programa para pintar a tela toda de vermelho no modo gráfico pixel a pixel

    ;Atribuição de 0 ao registrador "Data Segment" (ds)
    mov ax, 0x00
    mov ds, ax 

    ;limpa interrupções
    cli

    ;com AH = 0x00 e AL = 0x13, a interrupção 0x10 coloca o ví­deo no modo gráfico VGA 320x200 com 8 bits por pixel (256 cores)
    mov al, 0x13
    int 0x10

    ;Atribuição do endereço 0xA000 ao registrador "Extra Segment" (es),
    ;   para determinar o segmento de memória correspondente à memória de ví­deo no modo gráfico
    mov ax, 0xA000
    mov es, ax

    ;Registrador cx para contagem do laço (repetição de 320*200 = 64000 vezes)
    mov cx, 64000

    ;Usar registrador bx como contador para definir o deslocamento de memória no registrador "Destination Index" (di)
    mov bx, 0

    ;laço que preenche as 64000 posições de memória a partir do endereço 0xA000 com o byte 40
    ;   (ou seja, atribui a cor vermelha a todos os pixels da tela de 320x200).
loop:
    mov di, bx
    mov [es:di], byte 40
    inc bx
    dec cx
    jnz loop

    hlt

    times 510 - ($-$$) db 0
    dw 0xaa55