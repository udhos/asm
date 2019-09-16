; nasm -felf64 strcopy.asm && ld strcopy.o && ./a.out

          global    _start

          section   .text
_start:

          ; strcopy
          ;
          mov rdi, buffer
          mov rsi, message
          xor rdx, rdx     ; store size in RDX
copy_loop:
          mov cl, [rsi]          
          cmp cl, 0
          je  copy_done
          mov [rdi], cl
          inc rsi
          inc rdi
          inc rdx
          jmp copy_loop
copy_done:

          mov       rax, 1                  ; system call for write
          mov       rdi, 1                  ; file handle 1 is stdout
          mov       rsi, buffer             ; address of string to output
                                            ; number of bytes in RDX
          syscall                           ; invoke operating system to do the write

          mov       rax, 60                 ; system call for exit
          xor       rdi, rdi                ; exit code 0
          syscall                           ; invoke operating system to exit

          section   .data
message:  db        "hello", 10, 0
buffer:   resb    64              ; reserve 64 bytes
