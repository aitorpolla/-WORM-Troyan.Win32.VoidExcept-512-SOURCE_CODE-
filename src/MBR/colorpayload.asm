;Este, es el bootloader de VoidExcept-512, Skidding libre!


[BITS    16]
[ORG 0x7C00]

WSCREEN equ 320
HSCREEN equ 200

call setup
call palette

setup:
	mov ah, 0x00
	mov al, 0x13
	int 0x10
		
	push 0xA000
	pop es
		
	mov ah, 0x0C

	xor al, al   
	xor bx, bx   
	xor cx, cx   
	mov dx, 0x08 
	
	fninit
		
	call text
		
	ret

;-------------------------------------			
		
reset:	
	xor cx, cx
	mov dx, 0x08
	
	inc word [color]
		
	palette:
		mov word [x], cx
		mov word [y], dx
		
		cmp word [color], 2048
				
		cmp word [color], 1792
				
		cmp word [color], 1536
		
		cmp word [color], 1280
		
		cmp word [color], 1024
		;En esta parte del codigo la elimine debido a que ps los otros efectos no se ponian
		cmp word [color], 768
				
		cmp word [color], 512
				
		cmp word [color], 256
				
		cmp word [color], 30
		ja scroll
		jb statics
				
		setpixel:
			cmp cx, WSCREEN
			jae nextline
					
			cmp dx, HSCREEN
			jae reset

			int 0x10

			inc cx
			jmp palette
						
			ret

;-------------------------------------	

statics:	
        mov bp, cx
        add bp, [color]
        mov bx, bp

        add bl, [color]
        shr bl, 2

        mov al, bl
        shr al, 1

        and al, 0x3F
        or  al, 0x10


scroll:
        mov bx, cx
        xor bx, dx

        add bl, [color]
        mov al, bl
        shr al, 2

        and al, 0x3F
        or  al, 0x10

        jmp setpixel
		
		
;-------------------------------------	
		
HSV:
	
	cmp al, 55
        ja delhsv
        
        cmp al, 32
        jb addhsv
		
	jmp setpixel

delhsv:
        sub al, 16
        jmp HSV
        
addhsv:
        add al, 32
        jmp HSV
		
;-------------------------------------			
		
GRAY:
	cmp al, 31
        ja delgray
        
        cmp al, 16
        jb addgray
		
	jmp setpixel
		
delgray:
	sub al, 16
        jmp GRAY

addgray:
	add al, 32
        jmp GRAY
		
;-------------------------------------	
                
nextline:
        xor cx, cx
        inc dx

        jmp palette 
						
;-------------------------------------	

text:	
        
        push ax
        push bx

        
        mov ax, cx
        mov ds, ax

        
        mov ah, 0x0E
        mov si, string
        mov al, [si]

        xor bh, bh          ; video page
        mov bl, 0x0F        ; BLANCO PURO
		
	returnFirstColor:
		;Min Color
		mov bl, 0x0F
		
		printLoop:

        int 10h             

        inc si
        mov al, [si]
        cmp al, 0x00
        jnz printLoop

       
        pop bx
        pop ax						
        ret

;-------------------------------------	


string: db "Look. GREY + COLOR MERGING IN THE VOID", 0x00

color: dw 0		

x: dw 0
y: dw 0

zx: dd 0.0
zy: dd 0.0

a: dd 0.0
b: dd 0.0

;-------------------------------------
	
times 510 - ($ - $$) db 0
dw 0xAA55
