Vlad Andrei-Alexandru
321 CB

							=== TEMA 1 IOCLA ===
									-RPN-
					
		Pentru implementarea temei am parcurs urmatorii pasi:
	
	*Am resetat toti registrii de care aveam nevoie pentru siguranta.
	
	*Am folosit registrul ecx ca si constanta (ecx = 10) pentru a putea
inmultii cifrele anterioare pentru a forma un numar cu noile unitati. 
	(ab = a*ecx + b)
	
	*Parcurg fiecare octet din string cu ajutorul indexului esi, verific
daca s-a terminat linia de parsat (octetul = 0) sau nu.
	
	*Verific restul operatorilor si fac salturi conditionate in functie de
fiecare.
	
	*Daca octetul trece de toate testele de semn inseamna ca acel octet este
o cifra. Convertesc caracterul ascii la intreg apoi verific daca este prima
cifra citita sau nu.
	
	*Daca este prima cifra verific daca numarul pe care il voi forma va fi 
negativ sau pozitiv (edi = 1 sau edi = 0). Fac operatiile necesare pentru a
incepe formarea numarului apoi trec la citirea urmatorului caracter.
	
	*Pentru stocarea numarului format am ales sa il introduc in stiva, iar
cand numarul nu este format complet (nu s-a ajuns la urmatorul 'space')
scot din stiva numarul in curs de formare, il inmultesc cu 10 si adaug noua
unitate.
	
	*Pentru fiecare operatie scot ultimii 2 operanzi din stiva si aplic operatia
necesara. Rezultatul acestora va fi introdus in stiva. 
	
	*Calculul expresiei totale se realizeaza pe aceasta idee in continuare.
	
	*La final, cand intalnesc caracterul 0 (null) mai verific inca o data daca
ultima operatie a fost scadere sau nu deoarece doar dupa ce intalnesc un spatiu
verific prin intermediul edi daca am operatie de scadere sau nu. Dupa ce s-au
efectuat toate calculele afisez rezultatul deja calculat care este ultimul
element din stiva.

PUNCTAJ:
	Pe masina locala obtin 80/80 puncte.
	
	