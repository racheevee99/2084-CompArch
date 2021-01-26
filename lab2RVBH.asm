; Rachel Vetter and Bailey Hornsby
	.MODEL	small
	.STACK	100h
	.DATA
Var1	DB	13,10, "Nothing to pay",13,10,'$'			;string
Var2	DB	13,10, "Required to pay one cent",13,10,'$'		;string

	.CODE
Main:	mov	ax,@data		;These instructions will always be
	mov	ds,ax			;at the beginning of the program
	
	mov	ah,1			;reads a value into AL
	int 	21h
	sub 	al,30H			;changes AL to decimal
	mov 	bl,al			;moves AL to BL

	mov	ah,1			;reads a value into AL
	int	21h
	sub	al,30H			;changes AL to decimal
	mov	bh,al			;moves AL to BH
	
	add	bl,bh			;adds BL and BH and stores in BL
	
	CMP	bl,10			;compared BL to 10
	JGE	pay			;>= jump to Pay
	JL	noth

noth:	mov	ah,9			;these 3 instructions print the 
	lea	dx,Var1			;string Var1 to the screen
	int	21h
	JMP	done
	
pay:	mov	ah,9			;these 3 instructions print the 
	lea	dx,Var2			;string Var2 to the screen
	int	21h


done:	mov	ah,4ch			;these 2 instuctions end the program
	int	21h			;execution
	END	Main