section .data
  numero1: db 10
  numero2: dw 9
  numero3: dd 120
  msgpositive: DB 'todos son positivos', 10
  largo EQU $ - msgpositive
  msgnegative: DB 'todos son negativos', 10
  largo2 EQU $ - msgnegative
  msgposneg: DB 'hay positivos y negativos',  10
  largo3 EQU $ - msgposneg
                               
global _start
section .text

  _start:                

    ; En las etiquetas numero1, numero2 y numero3 se encuentran los tres numeros a comparar
    mov al, [numero1] ;en al guardo el primer numero
    mov bx, [numero2] ;en bx guardo el segundo numero
    mov ecx, [numero3] ;en ecx guardo el tercer numero
    call tresNumeros
    
    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80                   

tresNumeros:
  mov sil, 0 ;cantidad de positivos
  mov dil, 0 ;cantidad de negativos
  cmp al, 0 ;comparo el primer numero con 0
  js negativo1 ;si es negativo, saltamos
  add sil, 1 ;si es positivo, incrementamos sil
  jmp num2 ;saltamos al segundo numero

negativo1:
  add dil, 1 ;si es negativo, incrementamos dil

num2:
  cmp bx, 0 ;comparo el segundo numero con 0
  js negativo2 ;si es negativo, saltamos
  add sil, 1 ;si es positivo, incrementamos sil
  jmp num3 ;saltamos al tercer numero

negativo2:
  add dil, 1 ;si es negativo, incrementamos dil

num3:
  cmp ecx, 0 ;comparo el tercer numero con 0
  js negativo3 ;si es negativo, saltamos
  add sil, 1 ;si es positivo, incrementamos sil
  jmp imprimir ;saltamos a imprimir

negativo3:
  add dil, 1 ;si el tercer numero es negativo, incrementamos dil

imprimir:
  cmp dil, 3 ;comparo el contador de negativos con 3
  jz printnegative ;si el resultado es cero, entonces los tres numeros son negativos
  cmp sil, 3 ;comparo el contador de positivos con 3
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
  mov rdx, largo2
  int 0x80
  jmp fin

printposneg:
   mov rax, 4
  mov rbx, 1
  mov rcx, msgposneg
  mov rdx, largo3
  int 0x80
  jmp fin
  

fin:
ret

