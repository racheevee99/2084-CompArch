;Rachel Vetter and Bailey Hornsby Lab 12

.MODEL	small
	.STACK	100h
	.DATA
	.CODE
; airplane code starts here, assuming DX has its position
DPLANE  PROC 	NEAR
;draws the airplane
	push 	AX
	push	BX
	push	CX
	push	DX
;position tail
	MOV 	AH,2	;sets cursor in a specified screen position
	MOV 	BH,0	;define screen page to be used
	PUSH 	DX	; saves position for next line
	INT 	10H	
	mov 	dl,0dch	; prints 
	mov 	ah,2
       	int 	21h
       	mov 	dl,20h	; prints space
       	int 	21h
	mov 	dl,0ddh	; prints 
       	int 	21h
;position body
	POP   	DX
	ADD 	DH,1	;sets cursor in the next line (uses the same column)
	INT 	10H
	PUSH 	DX	; saves position for next line
	mov 	dl,0dbh ; prints 
      	int 	21h
       	mov 	dl,0dbh
	int 	21h
       	mov 	dl,0dbh
       	int 	21h
       	mov 	dl,010h	;prints  
       	int 	21h
;position wing
	POP   	DX
	ADD 	DH,1	;sets cursor in the next line (uses the same column)
	INT 	10H
       	mov 	dl,20h 	; prints space
       	int 	21h
       	mov 	dl,20h
       	int 	21h
       	mov 	dl,0ddh	;prints 
       	int 	21h
;restore registers
	pop	dx
	pop 	cx
	pop	bx
	pop 	ax
	ret
DPLANE	ENDP	
;----------------------------------------------------------------------------
EPLANE  PROC 	NEAR
;erases the airplane
	push 	AX
	push	BX
	push	CX
	push	DX
;position tail
	MOV 	AH,2	;sets cursor in a specified screen position
	MOV 	BH,0	;define screen page to be used
	PUSH 	DX	; saves position for next line
	INT 	10H	
	mov 	dl,020h	; prints 
	mov 	ah,2
       	int 	21h
       	mov 	dl,20h	; prints space
       	int 	21h
	mov 	dl,020h	; prints 
       	int 	21h
;position body
	POP   	DX
	ADD 	DH,1	;sets cursor in the next line (uses the same column)
	INT 	10H
	PUSH 	DX	; saves position for next line
	mov 	dl,020h ; prints 
      	int 	21h
       	mov 	dl,020h
	int 	21h
       	mov 	dl,020h
       	int 	21h
       	mov 	dl,020h	;prints  
       	int 	21h
;position wing
	POP   	DX
	ADD 	DH,1	;sets cursor in the next line (uses the same column)
	INT 	10H
       	mov 	dl,20h 	; prints space
       	int 	21h
       	mov 	dl,20h
       	int 	21h
       	mov 	dl,020h	;prints 
       	int 	21h
;restore registers
	pop	dx
	pop 	cx
	pop	bx
	pop 	ax
	ret
EPLANE	ENDP	; end of airplane code...

Main: 	mov	ax,@data		;These instructions will always be
	mov	ds,ax			;at the beginning of the program

;clearing the screen
	mov 	ax, 0600H
	MOV	BH,7
	MOV 	CX,0
	MOV	DX, 184FH
	INT	10H
; next two lines should go in the main progrgam to establish initial position
	mov	dh,12
	mov	dl,12
	push	dx

ACT:	mov 	ax, 0600H
	MOV	BH,7
	MOV 	CX,0
	MOV	DX, 184FH
	INT	10H
	pop	dx
;Draw the airplane
	call	DPLANE
;read in command
	mov 	ah,7
	int	21h
;compare command
	cmp	al, 0DH
	JE	adone
	cmp	al,73H
	JE	S
	cmp	al, 77H
	JE	W
	cmp 	al,7AH
	JE	Z
	cmp 	al, 61H
	JE	A
adone:	JMP	done
;execute command
S:	mov	ah,2
	mov	bh,0
	add	dl,1
	JMP	CHK
W:	mov	ah,2
	mov	bh,0
	sub	dh,1
	JMP	CHK
Z:	mov	ah,2
	mov	bh,0
	add	dh,1
	JMP	CHK
A:	mov	ah,2
	mov	bh,0
	sub	dl,1

CHK:	cmp	dl,0
	JL	ONE
	cmp	dl,76
	JG	TWO
	cmp	dh,0
	JL	THR
	cmp	dh,23
	JG	FOUR
	push	dx
	JMP	ACT

ONE:	mov	dl,0
	push	dx
	JMP	ACT
TWO:	mov	dl,76
	push	dx
	JMP 	ACT
THR:	mov	dh,0
	push	dx
	JMP	ACT
FOUR:	mov	dh,23
	push	dx
	JMP	ACT

Done:	mov	ah, 4ch
	int	21h
	END	Main