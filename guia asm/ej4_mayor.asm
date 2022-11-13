section .data
  arreglo: dw 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
                               
global _start
section .text

  _start:                

    ; En la etiqueta arreglo se encuentran los 16 numeros a comparar.
    ; dejar el resultado en eax
    mov rdi, arreglo
    call mayor

    ; Imprimo el valor en rax
    mov rdi, rax ; paso como parametro rax como rdi
    call printHex

    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80

mayor:
  mov rcx, 0 ;rcx es el iterador
  mov eax, 0 ;en eax va a estar el numero mayor del array (por hora 0)

ciclo:
  mov rdx, [rdi+rcx*2] ;guardamos en rdx el elemento siguiente
  inc rcx ;incrementamos el iterador
  cmp eax, edx ;comparamos el anterior con el siguiente
  js esmayor ;si el siguiente es mayor o igual, saltamos a esmayor
  cmp rcx, 16 ;comparo iterador con cantidad de elementos
  js ciclo ;mientras sea negativo, el ciclo se repite
  jmp fin

esmayor:
  mov eax, edx
  cmp rcx, 16 ;comparo iterador con cantidad de elementos
  js ciclo ;mientras sea negativo, el ciclo se repite

fin:
  ret

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
