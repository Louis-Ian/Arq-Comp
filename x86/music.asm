        org 0x7C00  ;Será carregado pela BIOS (Basic I/O System) em 0x7C00
        bits 16      ;Está em 'modo real', 16 bits
        
        mov     al, 182         
        out     43h, al         
        mov     ax, 4560        
        out     42h, al         
        mov     al, ah          
        out     42h, al 
        in      al, 61h         
        or      al, 00000011b   
        out     61h, al         
        mov     bx, 25          
pause1:
        mov     cx, 65535
pause2:
        dec     cx
        jne     pause2
        dec     bx
        jne     pause1
        in      al, 61h         
                                
        and     al, 11111100b   
        out     61h, al         

        times 510 - ($-$$) db 0   ;Limpa os restante dos bit pra 0
        dw 0xAA55                 ;Assinatura de boot