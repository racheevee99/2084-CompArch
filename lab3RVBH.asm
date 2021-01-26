; Rachel Vetter and Bailey Hornsby
	.MODEL	small
	.STACK	100h
	.DATA
Var1	DB	13,10, "Good result",13,10,'$'			;string
Var2	DB	13,10, "Insufficient funds",13,10,'$'		;string

	.CODE
Main:	mov	ax,@data		;These instructions will always be
	mov	ds,ax			;at the beginning of the program

	mov	dx, 0			;initializes total
	mov	cl,0			;initializes count
LUP:	cmp	cl,3			; CL < 3
	jge	done

	mov	ah,1			;reads a value into AL
	int 	21h
	sub 	al,30H			;changes AL to decimal
	mov 	bl,al			;moves AL to BL

	mov	ah,1			;reads a value into AL
	int	21h
	sub	al,30H			;changes AL to decimal
	mov	bh,al			;moves AL to BH
	
	mov	al, bl
	mul	bh			;multiply BH by AL and store in AX
	add	dx, ax			;adding AX to total and storing in DL
	
	add	cl,1
	jmp	LUP
	
done:	mov	ax,dx			;moves total to AX
	mov 	ch,3			;stores 3 in DH
	div	ch			;divides AX by DH and stores in AL and remainder in AH

	CMP	al,20			;compared AL to 20
	JGE	pay			;>= jump to Pay

	mov	ah,9			;these 3 instructions print the 
	lea	dx,Var2			;string Var1 to the screen
	int	21h
	jmp	stop
	
pay:	mov	ah,9			;these 3 instructions print the 
	lea	dx,Var1			;string Var2 to the screen
	int	21h

stop:	mov	ah,4ch			;these 2 instuctions end the program
	int	21h			;execution
	END	Main