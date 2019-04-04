DECRIPTARE macro
local citire_cheie_noua_decript, newline_afisare_decript, citire_din_1024_decript, verif_decript, inchidere_fisier_decript
	mov count_1024, 0
	mov count_chei, 0
	mov numarare_1024_totale, 0
	mov numarare_chei_totale, 0
	
	push offset trecere_operatii
	push offset format_citire
	call printf
	add ESP, 8
	push offset newline
	call printf
	add ESP, 4
	push offset trecere_operatii
	push offset format_citire
	call printf
	add ESP, 8
	push offset newline
	call printf
	add ESP, 4
	push offset trecere_operatii
	push offset format_citire
	call printf
	add ESP, 8
	push offset newline
	call printf
	add ESP, 4
	push offset trecere_operatii
	push offset format_citire
	call printf
	add ESP, 8
	push offset newline
	call printf
	add ESP, 4
	push offset trecere_operatii
	push offset format_citire
	call printf
	add ESP, 8
	push offset newline
	call printf
	add ESP, 4
	
	
	xor eax, eax
	push offset mode_r
	push offset fisier_criptari
	call fopen
	add esp, 8
	mov fisier_1024, eax ; salvam pointer-ul la fisierul cu cele 1024 numere din care tot citesc
	
	; deschidem fisierul cu cele 32 chei
	xor eax,eax
	push offset mode_r
	push offset fisier_chei
	call fopen
	add esp, 8
	mov fisier_deschis_chei, eax ; salvam pointer-ul la fisierul cu cele 32 de chei de criptare
	
	; deschidem fisierul pentru scriere
	xor eax,eax
	push offset mode_w
	push offset fisier_decriptari
	call fopen
	add esp, 8
	mov fisier_scriere_decriptari, eax ; salvam pointer-ul la fisierul unde o sa scriu datele criptate
	
	citire_cheie_noua_decript:	; citim cheile aici
	cmp numarare_chei_totale, 32
	je inchidere_fisier_decript
	mov numarare_1024_totale, 0
	push offset sir_cheie
	push offset format_citire
	push fisier_deschis_chei
	call fscanf
	add numarare_chei_totale, 1
	cmp eax, 1
	jne inchidere_fisier_decript
	jmp citire_din_1024_decript
	
	newline_afisare_decript:
	push offset newline
	push fisier_scriere_decriptari
	call fprintf
	add esp, 4
	
	push offset newline
	call printf
	add ESP, 4
	
	push offset newline
	call printf
	add ESP, 4
	
	push offset operatia_decriptare
	push offset format_citire
	call printf
	add ESP, 8
	
	push offset newline
	call printf
	add ESP, 4
	
	jmp citire_din_1024_decript
	
	citire_din_1024_decript:
	mov count_1024, 0
	cmp numarare_1024_totale, 32
	je citire_cheie_noua_decript
	; citim din fisierul cu 1024 linii
	push offset sir_citit
	push offset format_citire
	push fisier_1024 ;pointerul fisierului 
	call fscanf
	add numarare_1024_totale, 1
	cmp eax, 1	
	jne inchidere_fisier_decript

	push offset sir_citit
	push offset format_citire
	call printf
	add ESP, 8
	push offset newline
	call printf
	add ESP, 4
	push offset sir_cheie
	push offset format_citire
	call printf
	add ESP, 8
	push offset newline
	call printf
	add ESP, 4
	
	verif_decript:
	xor EBP, EBP
	mov EBP, count_1024
	cmp EBP,32
	je newline_afisare_decript
	;je citire_din_1024	; daca a parcurs toti cei 32 de biti dintr-un numar (unul din cei 1024), atunci sarim la eticheta unde citim alt numar
	xor ebx, ebx 	; facem ebx sa fie 0
	mov BL, sir_citit[EBP]
	sub BL, 30
	xor edx, edx
	xor EBP, EBP
	mov EBP, count_1024
	mov DL, sir_cheie[EBP]
	sub DL, 30
	xor EBX, EDX
	
	push EBX
	push offset format_afisare
	push fisier_scriere_decriptari
	call fprintf
	add ESP, 12
	
	xor EBP, EBP
	mov EBP, count_1024
	xor ebx, ebx
	mov BL, sir_citit[EBP]
	sub BL, 30
	xor edx, edx
	xor EBP, EBP
	mov EBP, count_1024
	mov DL, sir_cheie[EBP]
	sub DL, 30
	xor EBX, EDX
	
	push EBX
	push offset format_afisare
	call printf
	add ESP, 8
	
	add count_1024, 1
	jmp verif_decript

	
inchidere_fisier_decript:
	add esp, 24
	push fisier_1024 
	call fclose
	add esp,4
	
	push fisier_deschis_chei
	call fclose
	add esp,4
	
	push fisier_scriere_decriptari
	call fclose
	add esp, 4
endm