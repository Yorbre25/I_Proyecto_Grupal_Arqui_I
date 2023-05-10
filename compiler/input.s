start:
    ld r1,r15,r3
    ld r1, r15
branch1:
    add r2,r6,#2
    add r4, r3, r9
    add r4, r3, r9
    bi branch3
branch2:
    add r4, r3, r9
    bi branch1
branch3:
    add r4, r3, r9