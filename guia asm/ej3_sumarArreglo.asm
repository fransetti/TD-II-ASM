section .data
  arreglo: dd -1,2,3,4,-5,6,7,8,9,-10
  msg: DB 'positivo', 10
  msg1: DB 'negativo', 10
  largo EQU $ - msg 
                               
global _start
section .text

  _start:                

    ; En la etiqueta arreglo se encuentran los 10 numeros a sumar.
    ; dejar el resultado en eax
    mov rdi, arreglo
    call sumarArreglo

    ; Imprimo el valor en rax
    mov rax, eax
    mov rdi, rax ; paso como parametro rax como rdi
    call printHex

    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80                   

sumarArreglo:
  mov rcx, 0 ;iterador
  mov eax, [rdi+rcx*4] ;guardo en eax la primera posicion
  mov rcx, 1
  mov r10, 10
  mov rbx, 0
  ret

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
  