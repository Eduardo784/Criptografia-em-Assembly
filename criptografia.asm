NAME "Prog"
ORG 100H
.MODEL small
.STACK 512d
.DATA
valores DB "Digite algo:$"
digite DB 10,13,"Digite o valor da chave para ser criptografado:$"
digite2 DB 10,13,"Digite o valor da chave para ser descriptografado:$"
aux DB "",10,13,"$"
chave DB 0
chave2 DB 0
contador DW 0 
vet DB 2 DUP(0)
.CODE
MOV AH, 09
LEA DX, valores 
INT 21H

MOV CX, 30
LEA SI, vet

laco:
MOV AH, 01
INT 21H
MOV [SI], AL
INC SI 
INC contador
CMP AL, 13
JE SAI 

loop laco

volta:
MOV AH, 09
LEA DX, digite
INT 21H

MOV AH, 01
INT 21H
SUB AL, 48
MOV chave, AL

MOV CX, contador
LEA SI,vet 

criptografa:
MOV AL, chave
XOR [SI],AL  
INC SI
loop criptografa 

MOV AH, 09
LEA DX, aux
INT 21H

MOV CX, contador
LEA SI,vet

imprimecriptografado:
MOV AH, 02
MOV DL, [SI]
INT 21H
INC SI
loop imprimecriptografado

MOV AH, 09
LEA DX, digite2
INT 21H

MOV AH, 01
INT 21H
SUB AL, 48
MOV chave2, AL

MOV AH, 09
LEA DX, aux
INT 21H

MOV CX, contador
LEA SI,vet 

descriptografa:
MOV AL, chave2
XOR [SI],AL  
INC SI
loop descriptografa

MOV CX, contador
LEA SI,vet 

imrimedescriptografado:
MOV AH, 02
MOV DL, [SI]
INT 21H
INC SI
loop imrimedescriptografado
JMP FIM
 
SAI:
  JMP volta

FIM:
MOV AH, 4CH
INT 21H
END