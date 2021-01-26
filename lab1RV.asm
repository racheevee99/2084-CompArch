; Rachel Vetter
	.MODEL	small
	.STACK	100h
	.DATA
Var	DB	"This is John PC adding two numbers: 25 + 53 = " ,13,10,'$'	;string
	.CODE
Main:	mov	ax,@data		;These instructions will always be
	mov	ds,ax			;at the beginning of the program
	
	mov	ah,9			;these 3 instructions print the 
	lea	dx,Var			;sting Var to the screen
	int	21h

	mov	al,25			;these 2 instructions show how to 
	mov	bl,53			;initialize registers.
	add	al,bl			;this one shows how to add

	mov	dl,al			
	mov	ah,2			;these 2 instructions print whatever
	int	21h			;is in DL

	mov	ah,4ch			;these 2 instuctions end the program
	int	21h			;execution
	END	Main