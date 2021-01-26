; Rachel Vetter Computer Architecture Project
	.MODEL	small
	.STACK	100h
	.DATA
	.CODE

Main:	mov	ax,@data		;These instructions will always be
	mov	ds,ax			;at the beginning of the program

	mov	dx, 0			;initializes total
	mov	cx, 110H		;initializes count to 110H
LUP:	cmp	cx,111H			; CL < 111H
	jge	done

	add 	dx, cx			;accumulates total
	
	add	cx,1			;increments count
	jmp	LUP
	
done:	mov	ah,4ch			;these 2 instuctions end the program
	int	21h			;execution
	END	Main