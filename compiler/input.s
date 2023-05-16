salto:
not r1, #10
mov r2, #255
str r1, r2, r0
ld r10, r2, r0
add r11,r10,r1
sub r3, r1, r2
cmp r11,r3
beq salto
xor r4, r1, r2
cmp r1, #-11
beq salto