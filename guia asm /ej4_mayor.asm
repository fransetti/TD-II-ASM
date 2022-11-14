section .data
  arreglo: dw 1,2,3,4,5,6,7,8,16,10,11,12,13,14,15,1
                               
global _start
section .text

  _start:                

    ; En la etiqueta arreglo se encuentran los 16 numeros a comparar.
    ; dejar el resultado en eax
    mov edi, arreglo ;en edi guardo la direccion del arreglo
    call mayor

    ; Imprimo el valor en rax
    mov rdi, rax 
    call printHex

    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80 

mayor:
  mov cx, 0 ;cx es el iterador
  mov eax, 0 ;en eax va a estar el numero mayor del array (por hora 0)

ciclo:
  mov dx, [edi+ecx*2] ;en dx guardamos el elemento siguiente del array
  inc cx ;incrementamos el iterador
  cmp ax, dx ;comparamos el anterior con el siguiente
  js esmayor ;si el resultado es negativo es porque el siguiente es mayor, saltamos a esmayor
  cmp cx, 16 ;comparo iterador con cantidad de elementos del array
  js ciclo ;mientras sea negativo, el ciclo se repite
  jmp fin ;cuando terminemos, saltamos a fin

esmayor:
  mov ax, dx ;movemos a ax el nuevo numero mayor encontrado
  cmp cx, 16 ;comparo iterador con cantidad de elementos del array
  js ciclo ;mientras sea negativo, el ciclo se repite

fin:
  ret ;volvemos al main

; ---------------------------------------------
; printHex toma como parametro un valor en rdi
; e imprime dicho valor en hexadecimal
; ---------------------------------------------

printHex:
  push rbx
  push r12
  push r13
  push r14
  push r15
  push rbp
  mov rcx, 15
  mov rbx, hexachars
  .ciclo:
    mov rax, rdi
    and rax, 0xF
    mov dl, [rbx+rax]
    mov [number+rcx], dl
    dec rcx
    shr rdi, 4
    cmp rcx, -1
    jnz .ciclo
  mov rax, 4      ; funcion 4
  mov rbx, 1      ; stdout
  mov rcx, number ; mensaje
  mov rdx, 17     ; longitud
  int 0x80
  pop rbp
  pop r15
  pop r14
  pop r13
  pop r12
  pop rbx
ret

section .rodata
  hexachars: db "0123456789ABCDEF"

section .data
  number:    db "0000000000000000",10
