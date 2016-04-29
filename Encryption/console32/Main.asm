include \masm32\include\masm32rt.inc

.data
plainText BYTE 51 DUP(0),0
getString BYTE "Please enter a String (1-50 chars): ",0
cipherText BYTE 51 DUP(0),0
key BYTE 51 DUP(0),0
getKey BYTE "please enter a key: ",0
jkd BYTE 51 DUP(0),0
newLine BYTE 0ah,0dh,0

.code 
main proc

test1:
;;;;;;;;This is sending text to the console and getting the key/message;;;;
	invoke StdOut , ADDR getString
	invoke StdIn , ADDR plainText,50
	mov esi , eax
	push eax
	invoke StdOut , ADDR getKey
	invoke StdIn , ADDR key,50
;;;;;;;;;done getting the plaintext/key;;;;;;;;

;;;;;;;;;;;padding key;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;/end padding key;;;;;;;;
endPad:
;;;;;;;;;encrypting the message;;;;;;;;;;;;;
	pop eax
	mov esi , eax
	mov edi , 0
encrypt:
plainAdd:
	mov al , [plainText + edi]

keyAdd:
	mov bl , [key +edi]
	sub bl , 97
addN:
	add bl,al
check:
	cmp bl, "z"
	jng finish
	sub bl, 26
finish:
	
	mov [jkd+edi] , bl
	inc edi 
	dec esi 
	cmp esi , 0
	jnz encrypt

;;;;;;;;;encryption finished;;;;;;;;;;;;;

Finish:

	invoke StdOut , ADDR [jkd]

	mov eax,0
	ret
main endp
end main