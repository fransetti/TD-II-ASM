section .data                  
  msg: DB 'H',10,'o',10,'l',10,'a',' ',10,'F',10,'r',10,'a',10,'n',10,'c',10,'o',10 
  largo EQU $ - msg            

global _start                
section .text

  _start:                

    call nombre

    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80                   

nombre:
  mov rax, 4
  mov rbx, 1
  mov rcx, msg
  mov rdx, largo
  int 0x80
ret
