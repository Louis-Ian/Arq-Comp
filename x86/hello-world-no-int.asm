        org 0x7C00
        bits 16
        ;Hello World através de escrita direta na memória de vídeo (sem uso de interrupção)

        ;Atribuição de 0 ao registrador DS (Data segment)
        mov ax, 0x00
        mov ds, ax

        ;limpa interrupções
        cli

        ;Atribui ao registrador SI (Source Index) o endereço do primeiro byte da mensagem
        mov si, msg

        ;Atribuição do endereço 0cB800 ao registrador ES (Extra Segment),
        ;   para determinar o segmento de memória correspondente à memória de vídeo
        mov bx, 0xB800
        mov es, bx

        ;Usar registrador cx como contador para definir o deslocamento de memória no registrador DI (Destination Index)
        mov cx, 0

        ;Laço que pega cada caractere pelo endereço no registrador SI e o coloca na memória de vídeo,
        ;   repetindo o processo até encontrar o bite '0' na mensagem
loop:   lodsb
        or al, al
        jz fim
        mov di, cx
        mov [es:di], al
        add cx, 2
        jmp loop

        ;Para o processador
fim:    hlt

        ;Mensagem, complemento de 512 bytes & bytes de identificação de boot
msg:
        db "hello world"
        times 510 - ($-$$) db 0
        dw 0xAA55