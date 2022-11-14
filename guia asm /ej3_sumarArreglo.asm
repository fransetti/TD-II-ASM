section .data
  arreglo: dd -1,2,3,4,-5, 6,7,8,9,-10
  mensajepositivo: DB 'positivo', 10
  largo EQU $ - mensajepositivo
  mensajenegativo: DB 'negativo', 10
  largo2 EQU $ - mensajenegativo
                               
global _start
section .text

  _start:                

    ; En la etiqueta arreglo se encuentran los 10 numeros a sumar.
    ; dejar el resultado en eax
    mov rdi, arreglo
    call sumarArreglo

    ; Imprimo el valor en rax
    mov rdi, rax ; paso como parametro rax como rdi
    call printHex

    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80                   

sumarArreglo:
  mov rcx, 0 ;iterador
  mov eax, 0 ;inicializo eax en 0
  mov rdx, 10 ;en rdx guardo la cantidad de elementos del arreglo

ciclo:  
  add eax, [rdi+rcx*4] ;voy sumando
  inc rcx ;incremento el iterador
  cmp rcx, rdx ;resto el iterador con la cantidad de elementos
  js ciclo ;mientras sea negativo, el ciclo se repite
  cmp eax, 0 
  js negativo ;si el numero es negativo saltamos
  mov rax, 4
  mov rbx, 1
  mov rcx, mensajepositivo ;imprimimos esto si el numero es positivo
  mov rdx, largo
  int 0x80
  jmp fin

negativo: ;saltamos al final
  mov rax, 4
  mov rbx, 1
  mov rcx, mensajenegativo ;imprimimos esto si el numero es negativo
  mov rdx, largo
  int 0x80
  
fin:
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
  