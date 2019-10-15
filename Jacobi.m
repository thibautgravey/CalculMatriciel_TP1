function [X,E,LIMIT] = Jacobi(A,B,W)
% METHODE DE JACOBI RESOLVANT AX=B 
% A SE DECOMPOSE COMME A = D + L + U, D Diagonale
% JACOBI PREND M = D 

M = diag(diag(A)); %On garde la partie diagonale de la matrice
N = A - M; %On retire la partie diagonale pour faciliter le calcul de la somme avec éviter le if(i~=j) pour enlever la diagonale

L = size(A,1); %Taille du vecteur colonne X en (1,1)
C = size(A,2); %MATRICE CARRE DONC L=C
X = rand(L,1); %Solution de rang 0 (rang m+1 dans la suite des calculs) -> Quelconque au rang (0)
TMP = X; %Sauvegarde du rang m pour la méthode de Jacobi

S=0; %Somme de la formule de Jacobi

LIMIT = 0; %Eviter la boucle infinie

while (max(abs((A*X-B))) > W) && LIMIT < 10000000 %Restreindre les itérations (boucles infinis, GS doit converger en quelques itérations,genre 3 ou 4)
        for i = 1:L %On boucle sur les lignes de la matrice, pour trouver chaque composante de X de rang (m+1)
            for j = 1:C %On boucle pour chaque i sur toute la colonne de la matrice A pour calculer les composantes de X
                S = S + (N(i,j)*TMP(j)); %Attention la somme comprend les valeurs de X de rang m et non le rang (m+1) en cours de calcul
            end 
            X(i)=(B(i)-S)/M(i,i); %On fini le calcul de la i-ème composante de X en divisant par l'indice Ai,i
            S=0; %On réinitialise la somme
        end 
        TMP=X; %Sauvegarder le nouveau rang m
        LIMIT=LIMIT+1; %Gestion de la limite de boucle infinie
end 

E=abs(A*X-B); %On renvoi l'erreur pour vérifier
end

