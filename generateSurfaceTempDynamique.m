function [A,U] = generateSurfaceTempDynamique()
%METHODE DE MODELISATION DE NOTRE PROBLEME DYNAMIQUE

%PARAMETRES :
%A : 500*500 modélise les coefficients du problème
%U : Matrice colonne nulle de 500 lignes avec les conditions au bord
%X : Matrice colonne (500) avec l'évolution des températures points par points 

%Indexage pour passage 2D --> 1D : 1 en haut a gauche et on avance colonne
%par colonne de haut en bas. 

A = zeros(500,500);
U = zeros(500,1);

%Placement des points particuliers sur U

%On est des filous alors on va modifier les valeurs de U pour gérer les cas
%particuliers aka bordures à 100°C avant qui ne le sont plus et qui ont
%moins de voisins.
%PS : Promis à la fin du code on remet les U(i) relous à 0!

%Bord du haut -2 et du bas -3
for i = 21:20:461
    U(i)=-2;
end

for i = 30:20:230
    U(i)=-3;
    U(i+1)=-2;
end

for i = 40:20:480
    U(i)=-3;
end

%Bord de droite a -4
for i = 482:491
    U(i)=-4;
end

%FIN DE FILOUTERIE

%Points particuliers à 500 degrés
% M : 195, N : 215, O : 196, P : 216, I : 405, J : 425, K : 406, L : 426 
for i =  [195,215,405,425]
    U(i)=500;
    U(i+1)=500;
end

%Mise en place de A : 
%Cas général : Si U(i)=0 cad cas générale non bord : A(i,i)=-4, A(i,i+1)=A(i,i-1)=A(i,i+20)=A(i,i-20)=1
%               Sinon cad sur le bord, la température n'évolue pas : A(i,i)=1

%Attention aux rebouclages, on les gères de façon particulière ! Car 5 ou 3
%points
for i=1:500
    if (i==1)
        A(i,i)=-3;
        A(i,i+1)=1;
        A(i,i+20)=1;
        A(i,i+360)=1;
        
     elseif (i==10)
        A(i,i)=-3;
        A(i,i-1)=1;
        A(i,i+20)=1;
        A(i,i+360)=1;
        
    elseif (i==11)
        A(i,i)=-3;
        A(i,i+1)=1;
        A(i,i+20)=1;
        A(i,i+480)=1;
        
    elseif (i==20)
        A(i,i)=-3;
        A(i,i-1)=1;
        A(i,i+20)=1;
        A(i,i+480)=1;
        
    elseif (i==361)
        A(i,i)=-4;
        A(i,i-20)=1;
        A(i,i+20)=1;
        A(i,i+1)=1;
        A(i,i-360)=1;
        
    elseif (i==481)
        A(i,i)=-2;
        A(i,i+1)=1;
        A(i,i-20)=1;
        
    elseif (i==491)
        A(i,i)=-4;
        A(i,i-1)=1;
        A(i,i+1)=1;
        A(i,i-20)=1;
        A(i,i-480)=1;
        
    elseif (i==500)
        A(i,i)=-3;
        A(i,i-1)=1;
        A(i,i-20)=1;
        A(i,i-480)=1;
        
    elseif (U(i)==-2) %Bord haut et millieu du bas
        A(i,i)=-3;
        A(i,i+1)=1;
        A(i,i-20)=1;
        A(i,i+20)=1; 
        
    elseif (U(i)==-3) %Bord bas et millieu du haut
        A(i,i)=-3;
        A(i,i-1)=1;
        A(i,i-20)=1;
        A(i,i+20)=1; 
        
    elseif (U(i)==-4) %Bord droit
        A(i,i)=-3;
        A(i,i-1)=1;
        A(i,i-20)=1;
        A(i,i+1)=1;
        
    elseif ((i>=2) && (i<=9)) %4 voisins et rebouclage gauche / droite en haut (bord - pointillés)
        A(i,i)=-4;
        A(i,i-1)=1;
        A(i,i+1)=1;
        A(i,i+20)=1;
        A(i,i+360)=1;
        
    elseif ((i>=12) && (i<=19)) %4 voisins et rebouclage gauche / droite en bas (bord - bord)
        A(i,i)=-4;
        A(i,i-1)=1;
        A(i,i+1)=1;
        A(i,i+20)=1;
        A(i,i+480)=1;
        
    elseif ((i>=362) && (i<=370)) %5 voisins et rebouclage droite / gauche en haut (pointillés - bord)
        A(i,i)=-5;
        A(i,i-360)=1;
        A(i,i-20)=1;
        A(i,i-1)=1;
        A(i,i+1)=1;
        A(i,i+20)=1;
        
    elseif ((i>=492) && (i<=499)) %4 voisins et rebouclage droite / gauche en bas (bord - bord)
        A(i,i)=-4;
        A(i,i-1)=1;
        A(i,i+1)=1;
        A(i,i-20)=1;
        A(i,i-480)=1;
        
    else
       A(i,i)=-4;
       A(i,i+1)=1;
       A(i,i-1)=1;
       A(i,i+20)=1;
       A(i,i-20)=1;
       
    end
   
end


%RETOUR DE LA FILOUTERIE
%REINITIALISATION A 0 DANS LE RESPECT DE L'HOMO INFORMATIKO SAPIENS SAPIENS
%Bord du haut -2 et du bas -3
for i = 21:20:461
    U(i)=0;
end

for i = 30:20:230
    U(i)=0;
    U(i+1)=0;
end

for i = 40:20:480
    U(i)=0;
end

%Bord de droite a -4
for i = 482:491
    U(i)=0;
end

%FIN DE FILOUTERIE BIS
end
        



