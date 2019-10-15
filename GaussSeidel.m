function [X,E,LIMIT] = GaussSeidel(A,B,W)
% METHODE DE Gauss--Seidel RESOLVANT AX=B 
% A SE DECOMPOSE COMME A = D + L + U, D Diagonale, L Partie strictement inf
% Gauss-Seidel PREND M = D + L --> Méthode tril de Matlab donne la matrice
% triangulaire inférieure

D = diag(diag(A)); %On garde la partie diagonale de la matrice

M = tril(A) ; %Triangulaire inférieure de A

L = size(A,1); %Taille du vecteur colonne X en (1,1)
C = size(A,2); %MATRICE CARRE DONC L=C
X = rand(L,1); %Solution de rang 0 (rang m+1 dans la suite des calculs) -> Quelconque au range (0)
TMP = X; %Sauvegarde du rang m pour la méthode de Jacobi

S1=0; %Somme de la formule de GS avec le rang (m+1)
S2=0; %Somme de la formule de GS avec le rang (m)

LIMIT = 0; %Eviter la boucle infinie


while (max(abs((A*X-B))) > W) && LIMIT < 10000000 %On évite la boucle infini (doit converger après quelques itérations ~3 ou 4
        for i = 1:L %On boucle sur les lignes de la matrice, pour trouver chaque composante de X de rang (m+1)
            for j = 1:(i-1) %On boucle pour chaque i sur toute la colonne de la matrice A pour calculer les composantes de X
                S1 = S1 + (A(i,j)*X(j)); %On utilise dans cette somme, le X de rang courant (m+1)
            end 
            for k = (i+1):C
                S2 = S2 + (A(i,k)*TMP(k)); %On utilise dans cette somme, le X de rang ancien (m)
            end 
            X(i)=(B(i)-S1-S2)/A(i,i); %On fini le calcul de la i-ème composante de X en divisant par l'indice Ai,i
            S1=0; %On réinitialise les sommes
            S2=0;
        end 
        TMP=X; %Sauvegarder le nouveau rang m
        LIMIT=LIMIT+1; %Gestion de la limite de boucle infinie
end 

E=abs(A*X-B); %On renvoi l'erreur pour vérifier
end

