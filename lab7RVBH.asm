; Rachel Vetter and Bailey Hornsby
	.MODEL	small
	.STACK	100h
	.DATA
	.CODE
DOWN	proc	near			;open {
	mov	ah,2			;these two instructions print
	add	dl,30H			;the DL ASCII value to
	int	21H			;the screen
	ret				;return to main
DOWN	endp				;close }

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

	mov	ah, 0			;moves 0 to AH
	mov	ch,10			;moves 10 to CH
	div	ch			;divide AX by 10 and stores in AL and remainder in AH
	mov	bl, al			;moves AL to BL
	mov	bh,ah			;moves AH to BH
	
	mov	dl, bl			;moves AL to DL
	call	down			;calls down function
	
	mov	dl,bh			;moves AH to DL
	call	down			;calls down function

	mov	ah,4ch			;these 2 instuctions end the program
	int	21h			;execution
	END	Main