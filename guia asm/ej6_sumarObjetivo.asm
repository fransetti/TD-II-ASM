section .data
  arreglo:  dd 1,-2,3,0,-9,2,4,2,1,8
  objetivo: dd 5
                               
global _start
section .text

  _start:                

    ; En la etiqueta arreglo se encuentran los numeros a sumar y comparar
    ; en Objetivo se encuentra el numero que deben sumar en el caso que exista.

    call sumarObjetivo

    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80                   

sumarObjetivo:
  ; COMPLETAR
  ret