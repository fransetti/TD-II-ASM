section .data
  arreglo:  dd 1,2,3,3,9,2,4,2,2,8
  objetivo: dd 8
  msgverdadero: DB 'verdadero', 10
  largo EQU $ - msgverdadero
  msgfalso: DB 'falso', 10
  largo2 EQU $ - msgfalso
                               
global _start
section .text

  _start:                

    ; En la etiqueta arreglo se encuentran los numeros a sumar y comparar
    ; en Objetivo se encuentra el numero que deben sumar en el caso que exista.
    mov edi, arreglo ;en edi tengo la direccion del arreglo
    mov esi, [objetivo] ;en esi tengo el numero objetivo
    call sumarObjetivo

    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80                   

sumarObjetivo:
  mov cx, 0 ;cx es el iterador para el primer posible valor a sumar
  mov dx, 1 ;dx es el iterador para el segundo posible valor a sumar
  
ciclo:
  mov eax, [edi+ecx*4] ;en eax se encontrara el primer posible valor a sumar
  mov ebx, [edi+edx*4] ;en ebx se encontrara el segundo posible valor a sumar
  inc dx ;incrementamos el iterador del segundo elemento
  add eax, ebx ;sumo los dos posibles valores a sumar
  cmp eax, esi ;comparo el resultado de la suma con el numero objetivo
  jz verdadero ;si el resultado es 0, es porque es verdadero
  cmp dx, 10 ;comparamos el iterador del segundo valor con la cantidad del elementos del array
  js ciclo ;si es negativo, saltamos de vuelta al ciclo
  inc cx ;incrementamos el iterador del primer valor
  mov dx, 0 ;reiniciamos el iterador del segundo valor
  add dx, cx ;le sumamos al segundo iterador el primero
  inc dx ;le sumamos 1 al segundo iterador (esto es para que siempre empieza por delante del primero y que por ejemplo: no se sume la posicion 1 con la posicion 1)
  cmp cx, 10 ;comparamos el iterador del primer valor  con la cantidad de elementos del array
  js ciclo ;mientras sea negativo, saltamos al ciclo
  jmp falso ;si se termino todo el ciclo llegados a este punto, entonces es falso

verdadero:
  mov rax, 4
  mov rbx, 1
  mov rcx, msgverdadero
  mov rdx, largo
  int 0x80
jmp fin

falso:
  mov rax, 4
  mov rbx, 1
  mov rcx, msgfalso
  mov rdx, largo2
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


