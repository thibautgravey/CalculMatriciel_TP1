function [savew] = omega(A,B)
% A SE DECOMPOSE COMME A = D + L + U, D Diagonale, L Partie strictement inf
% Recherche du meilleur facteur d'optimisation du temps de convergence avec
% 0<w<2 avec une précision à 10^(-2) pour ensuite l'utiliser avec PI pour
% le calcul de la solution. Le meilleur se trouve en diminuant le rayon
% spectral rho pour augmenter la convergence vers la solution.
% w=1 : Méthode de GS
% w<1 : GS sous-relaxée
% w>1 : GS sur-relaxée
% U partie strictement sup

LINE = size(A,1); %Taille du vecteur colonne X en (1,1)

D=diag(diag(A)); %Matrice diagonale (partie diagonale de A)
L=tril(A,-1); %Matrice strictement inférieure venant de A
U=triu(A,1); %Matrice strictement supérieure venant de A

rho=0; %Recherche du rayon spectral;

saveRho=1; %On garde le plus petit rayon spectral, 1 aura une valeur 
%inférieure car 1 empeche la convergence
savew = 0; %Sauvegarder la valeur de w

X = rand(LINE,1); %Solution de rang 0 (rang m+1 dans la suite des calculs) -> Quelconque au rang (0)

for i=1:199
    w=i*0.01; %Par pas de 10^(-2)
    PI = ((D+w*L)^(-1))*((1-w)*D-w*U); %Calcul de la matrice PI avec le w courant
    
    rho=max(abs(eig(PI))); %Recherche du rayon spectral (PI) ie MAX des valeurs propres de PI
    
    if rho<=saveRho %Si c'est le rs le plus petit ie celui permettant une convergence rapide
        savew=w; %On save w courant permettant le plus petit rs
        saveRho=rho; %On garde rs pour comparer avec le suivant
    end
end

end