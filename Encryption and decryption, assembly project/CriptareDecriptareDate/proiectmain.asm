;srand
;rand = genereazza numarul random aleator
; EBX, EBP, ESI, EDI = merg ca indice pentru siruri
.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CRIPTARE / DECRIPTARE DE DATE 
;includem msvcrt.lib, si declaram ce functii vrem sa importam
includelib msvcrt.lib
include cript.asm
include decript.asm
extern printf: proc
extern fscanf: proc
extern fprintf: proc
extern fopen: proc
extern fclose: proc
extern exit: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
fisier_random db "random.txt", 0
fisier_chei db "keys.txt", 0
fisier_criptari db "criptare.txt", 0
fisier_decriptari db "decriptare.txt", 0

mode_r db "r", 0
mode_w db "w", 0
format_citire db "%s", 0
format_afisare db "%d", 0
newline db " ",0ah,0
operatia_criptare db "CRIPTARE DATE", 0
trecere_operatii db "URMEAZA PARTEA DE DECRIPTARE A DATELOR", 0
operatia_decriptare db "DECRIPTARE DATE", 0
sir_citit db 32 dup(0)	; aici o sa citesc sub forma de string, toata linia de 32 biti
sir_numar db 32 dup(0) ; aici o sa pun bit cu bit ce citesc din numarul ala citit din cele 1024 din fisierul random.txt
sir_cheie db 32 dup(0) ; aici o sa pun bit cu bit ce citesc din CHEIE
sir_final db 32 dup(0) ; aici o sa pun rezultatul dupa XOR
count_chei dd 0	; o sa contorizam pana la 32, numarul de biti dintr-o cheie citita
count_1024 dd 0	; o sa contorizam pana la 32, numarul de biti dintr-o linie din cele 1024
numarare_chei_totale dd 0 ;o sa contorizam pana la 32, pentru ca noi avem de citit 32 de chei in total
numarare_1024_totale dd 0 ;o sa contorizam din 32 in 32, pentru ca noi, pentru fiecare cheie, avem nevoie sa citim 32 de linii din fisierul cu 1024 linii
fisier_1024 dd 0
fisier_deschis_chei dd 0
fisier_scriere_criptari dd 0
fisier_scriere_decriptari dd 0
.code
start:

CRIPTARE
DECRIPTARE	

	push 0
	call exit
end start
