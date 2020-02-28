%include "io.inc"

%define MAX_INPUT_SIZE 4096

section .bss
	expr: resb MAX_INPUT_SIZE

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp

    GET_STRING expr, MAX_INPUT_SIZE

    ; your code goes here
    ;resetare registrii pentru siguranta
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    xor esi, esi                    ;index pentru octetii din string
    xor edi, edi                    ;edi = 1 daca se va citi - inainte de cifre
                                    ;edi = 0 implicit (numarul se considera pozitiv)
    
    ;ab = a*ecx + b
    mov ecx, 10
      
getChar:    
    movzx ebx, byte [expr + esi]
    inc esi                         
        
    ;verifica daca s-a terminat de parsat linia
    cmp ebx, 0
    je  final
    
    ;verifica caracterele din fiecare octet
    ;   ||
    ;   \/
    cmp ebx, ' '
    je  space
    
    cmp ebx, '+'
    je  plus
    
    cmp ebx, '-'
    je  minus
    
    cmp ebx, '*'
    je  inmultire
    
    cmp ebx, '/'
    je  impartire
    
    
    ;convertire char la int
    sub ebx, '0'
    
    ;Verifica daca octetul curent este prima cifra
    cmp esi, 1
    je prima_cifra
    
    cmp byte [expr + esi - 2], ' '
    je  prima_cifra
    cmp byte [expr + esi - 2], '-'
    je  prima_cifra
    cmp byte [expr + esi - 1], '9'
    jle  not_prima_cifra
    cmp byte [expr + esi - 1], '0'
    jge  not_prima_cifra
prima_cifra:
    cmp edi, 1      ;Verific daca numarul va fi negativ
    mov edi, 0      ;reseteaza registrul care retine nr neg sau scadere
    jne poz
neg:                ;prima cifra este negativa
    mov eax, -1
    imul ebx
    push eax
    jmp getChar   
    
poz:                ;prima cifra este pozitiva
    push ebx
    jmp getChar
    
not_prima_cifra:    ;aici se formeaza restul numarului
    pop eax
    mul ecx
    cmp eax, 0
    jge nr_poz
nr_neg:             ;daca numarul va fi negativ se scad unitatile curente
    sub eax, ebx
    push eax
    jmp getChar
    
nr_poz:             ;daca numarul va fi pozitiv se aduna unitatile curente
    add eax, ebx
    push eax
    jmp getChar


space:              ;cand apare space verific prin intermediul edi daca este operatie
    cmp edi, 1      ;de scadere sau nu
    mov edi, 0      ;reseteaza edi pentru urmatoare operatie sau pentru semnul urmatorului nr
    je scadere
    jmp getChar

plus:               ;operatia de adunare
    pop ebx
    pop eax
    add eax, ebx
    push eax
    jmp getChar

minus:              ;seteaza edi = 1
    mov edi, 1
    jmp getChar
    
scadere:            ;operatia de scadere
    pop ebx
    pop eax
    sub eax, ebx
    push eax
    jmp getChar

inmultire:          ;operatia de inmultire
    pop ebx
    pop eax
    imul ebx
    push eax
    jmp getChar
    
impartire:          ;operatia de impartire
    pop ebx
    pop eax
    cdq
    idiv ebx
    push eax
    jmp getChar
            
final:              ;s-a terminat de parsat linia si se verifica ultima operatie
    cmp edi, 1      ;se mai verifica inca o data daca ultima operatie a fost scadere
    jne afisare
    pop ebx
    pop eax
    sub eax, ebx
    push eax
        
afisare:            ;se afiseaza outputul
    pop eax
    PRINT_DEC 4, eax          

    mov esp, ebp
    xor eax, eax
    pop ebp
    ret
