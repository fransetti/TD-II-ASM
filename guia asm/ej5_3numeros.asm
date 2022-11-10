section .data
  numero1: db -10
  numero2: dw -9
  numero3: dd -120
                               
global _start
section .text

  _start:                

    ; En las etiquetas numero1, numero2 y numero3 se encuentran los tres numeros a comparar

    call tresNumeros

    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80                   

tresNumeros:
  ; COMPLETAR
  ret