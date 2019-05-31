    org 0x7c00
    bits 16

init:
    mov ax, 0x00
    mov ds, ax

    cli

    ; INT 0x10 / Ax <- 0x0013 = Graphic mode
    mov ah, 0x00
    mov al, 0x13
    int 0x10

main:
    call write_image

    cli
    hlt

write_image:
    push bp
    mov bp, sp
    pusha
    push es

    mov ax, 0xa000
    mov es, ax

    mov ah, 0x02    ; Code for interrupt 0x13
    mov al, 125     ; Number of sectors to read (0 <= al < 128)
    mov ch, 0       ; Track/Cylinder number (0 <= ch < 1023) 
    mov cl, 2       ; Sector number (1 <= cl < 17)
    mov dh, 0       ; Head number (0 <= dh < 15)
    mov dl, 0x80    ; Drive number (0=A:, 1=2nd floppy, 80h=drive 0, 81h=drive 1)
    ;  ES:BX <- Pointer to the buffer
    mov bx, 0 ; Pointer
    int 0x13

    pop es
    popa
    pop bp

    ret 1

bootloader_signature:
    times 510 - ($ - $$) db 0  ; Fill the remaining bytes wiht 0
    db 0x55                    ; The last 2 bytes must be 0x55AA
    db 0xaa

img_section: