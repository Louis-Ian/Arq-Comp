    org 0x7C00  ;Será carregado pela BIOS (Basic I/O System) em 0x7C00
    bits 16      ;Está em 'modo real', 16 bits
    ;hello world utilizando interrupção 0x10 (placa de vídeo)

    ;Atribui 0 ao registrador "Data Segment" (DS)
    mov ax, 0x00
    mov ds, ax

    ;limpa interrupções
    cli

    ;Atribui ao registrador "Souce Index" (SI) o endereço do primeiro byte da mensagem
    mov si, msg

    ;Pra interrupção 0x10 (vídeo), AH = 0x0E imprime o caractere na tela
    mov ah, 0x0E

    ;laço que pega cada caractere pelo endereço no registrador SI e o exibe através da interrupção 0x10, parando ao encontrar o byte '0'
loop:
    lodsb       ;Loads byte at address DS:SI into AL
    or al, al
    jz fim
    int 0x10
    jmp loop

    ;põe o processador em "Halt"
fim:
    hlt

    ;mensagem, complemento de 512 bytes + bytes de identificação do boot
msg:
    db "hello world"

    times 510 - ($-$$) db 0   ;Limpa os restante dos bit pra 0
    dw 0xAA55                 ;Assinatura de boot

