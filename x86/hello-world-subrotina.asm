    org 0x7c00
    bits 16
    ;programa para escrever mensagens na tela através de chamada da subrotina de escrita

    ;Atribuição de 0 ao registrador "Data Segment" (ds)
    mov ax, 0x00
    mov ds, ax 

    ;limpa interrupções
    cli

    ;determina endereço do primeiro byte da mensagem no registrador "Source Index" e chama subrotina para imprimir mensagem
    mov si, msg
    call prints

    ;determina endereço do primeiro byte de nova mensagem no registrador "Source Index"
    mov si, ola

    ;imprime três vezes a nova mensagem com três chamadas seguidas à subrotina "prints"
    call prints
    call prints
    call prints

    ;para processador
    hlt

    ;subrotina "prints"
prints:
    push si		;guarda valor do registrador "source index" (si) na pilha para restaurá-lo ao final da subrotina.
                ;   Isso possibilita repetidas chamadas da subrotina para uma mesma mensagem sem a necessidade de reatribuir o registrador "si"

    mov ah, 0x0e	;Para a interrupção 0x10, AH = 0x0E envia caractere para a tela.

    ;laço que pega cada caractere pelo endereço no registrador si e o exibe através da interrupção 0x10, parando ao encontrar o byte "0"
.loop:
    lodsb
    or al, al
    jz retorno
    int 0x10
    jmp .loop

retorno:
    pop si	;reestabelece o valor inicial do registrador "source index" (si), retirando o valor da pilha que havia sido guardado no início da execução da subrotina
    ret	;retorna da chamada à subrotina "prints"

    ;bytes das mensagens a serem escritas
msg: db "Hello world!", 13, 10, 0

ola: db "Ol", 160, " mundo!", 13, 10

    ;complemento dos 512 bytes e bytes de identificação de boot
    times 510 - ($-$$) db 0
    dw 0xaa55