include \masm32\include\masm32rt.inc

.data
encryptedM BYTE 51 DUP(0),0
key BYTE 51 DUP(0),0
plainText BYTE 51 DUP(0),0
getEnc BYTE "Enter the encrypted message: ",0
alph BYTE "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",0
getKey BYTE "Enter the key: "

.code 
main proc 

	invoke StdOut , ADDR getEnc
	invoke StdIn , ADDR encryptedM , 50
	mov esi , eax
	push eax
	invoke StdOut , ADDR getKey 
	invoke StdIn , ADDR key ,50

;;;;;;;;key padding;;;;;;;;;;

	cmp eax,esi
	je endPad
	sub esi , eax
	mov ecx , esi
	mov esi,0
	mov edi,eax
	
	padKey:
	mov al , [key+esi]
	mov [key + edi] , al
	inc esi
	inc edi
	loop padKey


;;;;;;;;;;/end keypadding;;;;;;;;
endPad:
;;;;;;;;;decrypion;;;;;;;;;;;;;;
	pop eax
	mov esi , eax
	mov edi , 0
decrypt:
	mov ecx,0
	mov bl , 0
	mov cl , [key + edi]
plainAdd:
	mov al , [encryptedM + edi]

keySub:
	mov dl ,[alph]
	cmp dl,cl
	je subN
	inc bl 
	loop keySub
subN:
	sub al,bl
check:
	cmp al, "a"
	jge finish
	add bl,26

finish:
	
	mov plainText , al
	invoke StdOut , ADDR [plainText]


	inc edi 
	cmp ebx,0
	je Finish
	dec esi 
	cmp esi , 0
	jnz decrypt
	
;;;;;;;;;/end decryption;;;;;;;

Finish:
	
	mov eax,0
	ret 
main endp
end main