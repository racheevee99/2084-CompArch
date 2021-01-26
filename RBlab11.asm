;Rachel Vetter and Bailey Hornsby
	.MODEL	small
	.STACK	100H
	.DATA
ZIRK	DB	8 DUP(0)
Var1	DB	13,10,"Contaminated",13,10,'$'
Var2	DB	13,10,"Clear",13,10,'$'
	.CODE
Main:	mov	ax,@data
	mov	ds,ax
	mov	ch,0		;initializes count
	lea	bx,ZIRK		;sets BX to the 1st address of ZIRK

Lup:	cmp	ch, 8		;ch<8 jump to outa
	je	Outa
	mov	ah,1		;these 3 lines read in value
	int	21h		;and store in AL
	sub	al,30h
	mov 	[bx],al		;places value from AL in [BX]
	add	ch,1		;increments count
	add	bx,1		;increments array
	jmp	Lup

Outa:	mov	ah,1		;these 3 lines read in value
	int	21h		;and store in AL
	sub	al,30h
	mov	dl,al
	lea	bx,ZIRK		;sets BX to the 1st adress of ZIRK
	mov	dh,0		;initializes DH to 0
	add 	bx,dx
	mov	dl,[bx]
	cmp	dl,1
	je	Con
	mov	ah,9
	lea	dx,Var2
	int	21h
	jmp	done

Con:	mov	ah,9
	lea	dx,Var1
	int	21h

Done:	mov	ah, 4ch
	int	21h
	END	Main