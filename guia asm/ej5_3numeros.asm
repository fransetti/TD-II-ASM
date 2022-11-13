section .data
  numero1: db -10
  numero2: dw -9
  numero3: dd -120
  msgpositive: DB 'todos son positivos', 10
  largo EQU $ - msgpositive
  msgnegative: DB 'todos son negativos', 10
  largo2 EQU $ - msgnegative
  msgposneg: DB 'hay positivos y negativos', 10
  largo3 EQU $ - msgposneg
                               
global _start
section .text

  _start:                

    ; En las etiquetas numero1, numero2 y numero3 se encuentran los tres numeros a comparar
    mov rax, 0
    mov rbx, 0
    mov rcx, 0
    mov al, [numero1]
    mov bx, [numero2]
    mov ecx, [numero3]
    

    call tresNumeros

  ; Imprimo el valor en rax
    ; paso como parametro rax como rdi
    
    
    

    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80                   

tresNumeros:
  mov rsi, 0 ;cant positivos
  mov rdi, 0 ;cant negativos
  mov rdi, rax
  call printHex
  
  cmp rax, 0 ;comparo el primer numero con 0
  js negativo1 ;si es negativo, saltamos
  add rsi, 1 ;si es positivo, incrementamos rsi
  jmp num2 ;saltamos al segundo numero

negativo1:

  add rdi, 1 ;si el primer numero es negativo, incrementamos rdi

num2:
  cmp rbx, 0 ;comparo el segundo numero con 0
  js negativo2 ;si es negativo, saltamos
  add rsi, 1 ;si es positivo, incrementamos rsi
  jmp num3 ;saltamos al tercer numero

negativo2:
  add rdi, 1 ;si el segundo numero es negativo, incrementamos rdi

num3:
  cmp rcx, 0 ;comparo el tercer numero con 0
  js negativo3 ;si es negativo, saltamos
  add rsi, 1 ;si es positivo, incrementamos rsi
  jmp imprimir ;saltamos a imprimir

negativo3:
  add rdi, 1 ;si el tercer numero es negativo, incrementamos rdi

imprimir:
  cmp rdi, 3 ;comparo el contador de negativos con 3
  jz printnegative ;si el resultado es cero, entonces los tres numeros son negativos
  cmp rsi, 3 ;comparo el contador de positivos con 3
  jz printpositive ;si el resultado es cero, entonces los tres numeros son positivos
  jmp printposneg ;sino, hay tanto positivos como negativos
  

printpositive:
  mov rax, 4
  mov rbx, 1
  mov rcx, msgpositive
  mov rdx, largo
  int 0x80
  jmp fin

printnegative:
   mov rax, 4
  mov rbx, 1
  mov rcx, msgnegative
  mov rdx, largo
  int 0x80
  jmp fin

printposneg:
   mov rax, 4
  mov rbx, 1
  mov rcx, msgposneg
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

  