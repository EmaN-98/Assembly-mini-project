.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem msvcrt.lib, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern printf: proc
extern scanf: proc
extern fopen: proc
extern fclose: proc
extern fgets: proc
extern fprintf: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data


format db "%s", 0
format2 db "%d",0
format5 DB "%c",13,10,0
opt1 db "1.Verificare",13,10,0
opt2 db "2.Apartenenta",13,10,0
opt3 db "3.Reuniune",13,10,0
opt4 db "4.Intersectie",13,10,0
meniu db "Alegeti optiunea dorita 1-4: ",13,10,0

x dd 100 dup(0),0
y dd 100 dup(0),0

N dd 0,0
Nn dd 0,0

citire1 db "Nr de elem dorite : ",0
citire2 db "Nr de elem dorite pt multimea a doua : ",0
DetectEgale db "caractere egale! ",0
NDetectEgale db "Nu sunt caractere egale. ",0
app db "Dati valoarea cautata : ",0
apart dd ?
NuApp db "Elementul cautat nu apartine multimii! ",0
DaApp db "Elementul cautat apartine multimii. ",0
nr db ?
nrR db ?
nrR2 db ?
nrI db ?
nrI2 db ?
n4 db ?
n5 db ?

aux dd ?
aux1 dd ?
aux2 dd ?
aux3 dd ?
aux4 dd ?
valoare dd 0
WriteMode db "w",0
AppendMode db "a",0
fName db " Rezultat.txt ",0
FisierOut db " Fisier out: Rezultat.txt ",0
msg db " Rezultatul :",13,10,0

aux11 dd ?








.code
start:
	;aici se scrie codul

verificare macro            ; trateaza operatia de verificare a multimii introduse in privinta unicitatii elementelor sale
local L1, L2, L3


push offset WriteMode                     ;afiseaza in fisier tipul operatiei ce va fi executata
		push offset fName
		call fopen
		add esp,8
		mov edi, eax
		push offset opt1
		push offset format
		push edi
		
		call fprintf
		add esp,12
		push edi
		call fclose
		add esp,4


push offset citire1        ; se anunta ca trebuie introdus nr de elem al multimii dorite
call printf
add esp,4

push offset nr           ; se citeste in nr numarul de elem al multimii
push offset format2
call scanf
add esp,8
xor eax,eax            ; se initializeaza eax la 0


mov al,nr              ; se pune nr de elem in eax si in aux
mov aux, eax
	mov edx,0          ; se initializeaza edx si esi la 0
	mov esi,0
	
mov ecx, eax
L1:                   ; se citesc pe rand elem multimii dorite si se pun in vectorul x
push ecx
	push offset N
	push offset format2 
	call scanf
	add esp,8
	mov eax,N
	mov x[esi],eax
	add esi,4
pop ecx
loop L1

mov ecx,aux
mov esi,0

L2:
	push ecx
	mov edi,esi       ; se pune adresa elem curent in edi
	add edi,4
	L3:
		push ecx
		mov eax,x[esi]   ; se pune urmatorul curent in eax
		cmp eax,x[edi]    ; se compara cele 2 elemente
		je egalee    ; se sare la blocul cu eticheta 'egalee' daca cele 2 sunt egale
		add edi,4
		pop ecx
	loop L3
	pop ecx
	add esi,4
loop L2
pop ecx
jmp NuEegal       ; in caz contrar, se sare la NuEegal

 egalee:
		push offset AppendMode            ; se deschide fisierul
	push offset fName
	call fopen
	add esp,8
	mov esi,eax
	
	push offset DetectEgale                ; se afiseaza mesajul ca sunt caractere egale, in fisier
	push esi
	call fprintf
	add esp,8
	push esi
	call fclose
	add esp,4
	
	push 0
	push offset DetectEgale               ; se afiseaza pe ecran acelasi mesaj
	call printf
	add esp,4
	push offset FisierOut
	call printf
	add esp,4
	jmp eticheta                 ; se iese pt a nu fi executat si blocul NuEegal
 
 NuEegal:
		push offset AppendMode             ; se deschide fisierul
		push offset fName
		call fopen
		add esp,8
		mov esi,eax
		
		push offset NDetectEgale            ; se afiseaza in fisier mesajul ca nu exista caractere egale
		push esi
		call fprintf
		add esp,8
		push esi
		call fclose
		add esp,4
		
		push 0
		push offset NDetectEgale           ; se afiseaza  pe ecran acelasi mesaj
		call printf
		add esp,4
		push offset FisierOut
		call printf
		add esp,4
		
endm


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


apartenenta macro                  ; verifica apartenenta unui element dat la multimea introdusa
	local loop1
	
	push offset WriteMode           ; afiseaza in fisier tipul operatiei alese
		push offset fName
		call fopen
		add esp,8
		mov edi, eax
		push offset opt2
		push offset format
		push edi
		
		call fprintf
		add esp,12
		push edi
		call fclose
		add esp,4
	
	
	
	push offset app                               ; 
	push offset format                            ;
call printf                                       ;
add esp,8                                         ;   se cere si se citeste valoarea cautata
push offset apart                                 ;
push offset format                                ; 
call scanf                                        ;
add esp,8                                         ;



push offset citire1                            ;
call printf                                    ;
add esp,4                                      ;
                                               ; se cere si se citeste nr de elem ale multimii
push offset nr                                 ;
push offset format2                            ;
call scanf                                     ;
add esp,8                                      ;


	mov al, nr
	mov aux,eax                           ; se pune nr de elem in eax,aux si apoi in ecx
	mov edx,0
	mov esi, 0

 

mov ecx,aux

loop1:               ; se citesc elem multimii, pe rand
push ecx

push offset N
push offset format
call scanf
add esp,8
mov eax,N
mov x[esi],eax
add esi,4
cmp apart, eax          ; daca se gaseste elementul, se sare la eticheta Yes
	je Yes

pop ecx
loop loop1

	push offset AppendMode
	push offset fName
	call fopen
	add esp,8
	mov esi,eax
                                         ; se deschide fisierul si se scrie in el mesajul ca elem nu se gaseste in multime
		push offset NuApp
		push esi
		call fprintf
		add esp,8

	push esi
	call fclose
	add esp,4
	
	push 0
	push offset NuApp             ; se afiseaza si pe ecran acelasi mesaj
	call printf
	add esp,4
	
	push offset FisierOut
	call printf
	add esp,4
	jmp eticheta



Yes:
	push offset AppendMode
	push offset fName
	call fopen
	add esp,8
	mov esi,eax
                                          ; se deschide fisierul si se scrie in el mesajul ca elem se gaseste in multime
		push offset DaApp
		push esi
		call fprintf
		add esp,8

	push esi
	call fclose
	add esp,4
	
	push offset DaApp             ; se afiseaza acelasi mesaj si pe ecran
	call printf
	add esp,4
	
	push offset FisierOut
	call printf
	add esp,4

endm



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     Pentru reuniune si intersectie, verificarea multimilor nu a mai fost necesara tinand cont
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     ca am folosit un singur vector in care am pus cele doua multimi si, prin urmare, chiar si 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     elementele aceleiasi multimi vor fi comparate intre ele.



 reuniune macro               ; trateaza operatia de reuniune
	 local loop1,loop2,loop3,loop4,loop6,loop7,loop10
	 
	push offset WriteMode             ; afiseaza in fisier tipul operatiei
		push offset fName
		call fopen
		add esp,8
		mov edi, eax
		push offset opt3
		push offset format
		push edi
		
		call fprintf
		add esp,12
		push edi
		call fclose
		add esp,4
		
		

 push offset citire1   ; se atentioneaza ca trebuie introdus nr de elemente pt multimea ce va fi introdusa
 call printf
 add esp,4

 push offset nrR         ; se citeste in nrR nr de elemente al multimii
 push offset format2
 call scanf
 add esp,8
 
 xor eax,eax           ; se sterge continutul registrului eax

	 mov al,nrR        ; se pune nr de elem in eax, iar de acolo in aux
	 mov aux,eax

	 mov edx,0      ; se initializeaza edx si esi cu 0
	 mov esi, 0


 mov ecx,eax          ; se copiaza nr de elem al multimii in ecx si in aux1
 mov aux1,eax
 loop1:
 push ecx

 push offset Nn      ; se citesc pe rand elem multimii si se pun in vectorul x
 push offset format2
 call scanf
 add esp,8
 mov eax,Nn
 mov x[esi],eax
 add esi,4
 
 push offset AppendMode         ; se scriu in fisier elem multimii
		push offset fName
		call fopen
		add esp,8
		mov edi,eax                                      
		
		push Nn
		push offset format2
		push edi
		call fprintf
		add esp,12
		push edi
		call fclose
		add esp,4
		
		
 
 

 pop ecx
 loop loop1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 push offset citire2       
 call printf
 add esp,4

 push offset nrR2        ; se citeste nr de elem al celei de-a doua multimi in nrR2
 push offset format2
 call scanf
 add esp,8
 
 xor eax,eax
 mov al,nrR2          ; se pune nr de elem si in eax, apoi in ecx si in aux2
 mov aux,eax
 mov ecx,eax         
 mov aux2,eax
 
 loop2:
 push ecx

 push offset Nn        ; se citesc elementele celei de-a doua multimi
 push offset format2
 call scanf
 add esp,8
 mov eax,Nn
 mov x[esi],eax
 add esi,4

 push offset AppendMode      ; se afiseazaa si in fisier elem acestei multimi
		push offset fName
		call fopen
		add esp,8
		mov edi,eax                                      
		
		push Nn
		push offset format2
		push edi
		call fprintf
		add esp,12
		push edi
		call fclose
		add esp,4
 
 
 pop ecx
 loop loop2
 
 
;;                                    ;;intersectie

mov esi,0
xor ecx,ecx
mov edx, 0
mov edx, aux1
add edx, aux2
mov ecx,edx
mov aux3,edx         ; aux va contine nr total de elem din cele 2 multimi

loop3:
	push ecx
	mov edi,esi
	add edi,4
	loop4:                  ; se compara elementele 2 cate 2
		push ecx
		mov eax,x[esi]
		cmp eax,x[edi]
		je acelasi             ; daca sunt egale cele 2 elem, se sare la eticheta 'acelasi', altfel la 'continua'
		add edi,4
		jmp continua

		acelasi:
		sub x[esi], eax           ; elementul care se repeta va deveni 0 pt a nu fi afisat de 2 ori:prima sa aparitie
		add edi, 4

		continua:
		pop ecx
	loop loop4
pop ecx
add esi,4
loop loop3

push offset msg         ; msg = 'Rezultatul'..va fi afisat pe ecran
call printf
add esp,4


	mov esi,0
		mov ecx,aux3
		loop6:                    ;; se compara elementele cu 0 si se afiseaza doar cele nenule, adica cele care nu se repeta
		push ecx
		cmp x[esi], 0       
		je no
		
		push x[esi]
		push offset format2
		call printf
		add esp,8
		no: add esi,4

		pop ecx
				
		loop loop6
	
;;;;;;;;;;;;;;;;;;;fisier
push offset FisierOut
call printf
add esp,4

mov esi,0
mov ecx,aux3
		loop7:              ; se afiseaza si in fisier reuniunea multimilor, dupa acelasi criteriu
		push ecx
		
		push offset AppendMode
		push offset fName
		call fopen
		add esp,8
		mov edi,eax                                      
		cmp x[esi],0
		je nno
		push x[esi]
		push offset format2
		push edi
		call fprintf
		add esp,12
		
		nno: add esi,4
		push edi
		call fclose
		add esp,4

		pop ecx
		loop loop7



 
 endm

 
 
 ; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



intersectie macro                ; trateaza intersectia multimilor
local loop1,loop2,loop3,loop4


push offset WriteMode           ; scrie in fisier tipul operatiei
		push offset fName
		call fopen
		add esp,8
		mov edi, eax
		push offset opt4
		push offset format
		push edi
		
		call fprintf
		add esp,12
		push edi
		call fclose
		add esp,4


push offset citire1
call printf
add esp,4
                           ; se cere si se citeste in nrI, nr elem primei multimi
push offset nrI
push offset format2
call scanf
add esp,8
mov al,nrI
xor eax,eax
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov al,nrI
	mov aux,eax

	mov edx,0
	mov esi, 0

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov ecx,eax
mov aux1,eax

loop1:                                    ; se citesc pe rand elem multimii
push ecx 

push offset N
push offset format2
call scanf
add esp,8
mov eax,N
mov x[esi],eax
add esi,4

 push offset AppendMode              ; se scriu in fisier elem
		push offset fName
		call fopen
		add esp,8
		mov edi,eax                                      
		
		push N
		push offset format2
		push edi
		call fprintf
		add esp,12
		push edi
		call fclose
		add esp,4
 

pop ecx
loop loop1

;;;;;;;;;;;;;;;;;;;;;;;

;;;   ;;;   ;;;   ;;;   ;;;

push offset citire2
call printf
add esp,4       
                                      ;; se cere si se citeste in nrI2, nr elem celei de-a doua multimi
push offset nrI2                    
push offset format2
call scanf
add esp,8
mov al,nrI2
xor eax,eax
	
mov al,nrI2
mov aux,eax

mov ecx,eax
mov aux2,eax


loop2:                           ; se citesc pe rand elem multimii
push ecx

push offset N
push offset format2
call scanf
add esp,8
mov eax,N
mov x[esi],eax
add esi,4
                              ; se scriu in fisier elem
 push offset AppendMode
		push offset fName
		call fopen
		add esp,8
		mov edi,eax                                      
		
		push N
		push offset format2
		push edi
		call fprintf
		add esp,12
		push edi
		call fclose
		add esp,4
 

pop ecx
loop loop2

;;;;;;;;;;;;;;;;


;                                        se realizeaza intersectia

	mov esi,0
	xor ecx,ecx
	mov edx, 0
	mov edx, aux1
	add edx, aux2
	mov aux11,edx
	mov ecx,aux11                 ; aux11 va fi totalul elem din cele doua multimi
	
	loop3:
		push ecx
		mov edi,esi
		add edi,4
		loop4:                           ; se compara elem 2 cate 2
			push ecx
			mov eax,x[esi]
			cmp eax,x[edi]
			je comun
			add edi,4
			jmp necomun

			comun:                    ; se afiseaza pe ecran elem comune
			push eax
			push offset format2
			call printf
			add esp, 8
			add edi, 4
			
			
			necomun:
			pop ecx
		loop loop4
		pop ecx
	add esi,4
	loop loop3

		push offset FisierOut
		call printf
		add esp,4
		

	endm
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
	
	
	
	

eticheta:
	push offset opt1           ; afisam pe ecran operatiile posibile pt ca utilizatorul sa o aleaga pe cea dorita
	call printf
	add esp,4
	push offset opt2
	call printf
	add esp,4
	push offset opt3
	call printf
	add esp,4
	push offset opt4
	call printf
	add esp,4
	push offset meniu       ; se cere sa se aleaga operatia dorita
	call printf
	add esp,4
	

	push offset valoare       ; se alege operatia dorita prin apasarea cifrei corespunzatoare : 1/2/3/4 care se pune in 'valoare' si apoi in esi
	push offset format2
	call scanf
	add esp,8
	mov esi,valoare


	cmp esi,1                ; se detecteaza operatia aleasa de utilizator
	je OperatieVerificare	
	cmp esi,2
	je OperatieApartenenta
    cmp esi,3
    je OperatieReuniune
	cmp esi,4
	je OperatieIntersectie
	
	
	
	OperatieVerificare: verificare
	jmp eticheta
	
	OperatieApartenenta: apartenenta
	jmp eticheta

	OperatieReuniune: reuniune
	jmp eticheta

	OperatieIntersectie: intersectie
	jmp eticheta


	
	;terminarea programului
	push 0
	call exit
end start







