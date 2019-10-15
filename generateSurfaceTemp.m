function [A,B] = generateSurfaceTemp()
%METHODE DE MODELISATION DE NOTRE PROBLEME SOUS LA FORME AX=B

%PARAMETRES :
%A : 500*500 modélise les coefficients du problème
%B : Matrice colonne nulle de 500 lignes avec les conditions au bord
%X : Matrice colonne (500) avec l'évolution des températures points par points 

%Indexage pour passage 2D --> 1D : 1 en haut a gauche et on avance colonne
%par colonne de haut en bas. 

A = zeros(500,500);
B = zeros(500,1);

%Placement des points particuliers sur B

%Bord du haut et du bas à 100°C
for i = [1,21,41,61,81]
    B(i)=100;
    B(i+19)=100;
    B(i+100)=100;
    B(i+119)=100;
    B(i+200)=100;
    B(i+219)=100;
    B(i+300)=100;
    B(i+319)=100;
    B(i+400)=100;
    B(i+419)=100;
end

%Bord de droite à 100°C
for i = 482:491
    B(i)=100;
end

%Bord au milieu à 100°C
for i = [10,30,50,70,90,110,130,150,170,190,210,230,250]
    B(i)=100;
    B(i+1)=100;
end

%Points particuliers à 500 degrés
% M : 195, N : 215, O : 196, P : 216, I : 405, J : 425, K : 406, L : 426 
for i =  [195,215,405,425]
    B(i)=500;
    B(i+1)=500;
end

%Mise en place de A : 
%Cas général : Si B(i)=0 cad cas générale non bord : A(i,i)=-4, A(i,i+1)=A(i,i-1)=A(i,i+20)=A(i,i-20)=1
%               Sinon cad sur le bord, la température n'évolue pas : A(i,i)=1

%Attention aux rebouclages, on les gères de façon particulière ! Car 5 ou 3
%points
for i=1:500
    if ((i>=2) && (i<=9)) %4 voisins et rebouclage gauche / droite en haut (bord - pointillés)
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
        
    elseif ((i>=462) && (i<=470)) %5 voisins et rebouclage droite / gauche en haut (pointillés - bord)
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
        
    elseif (B(i) == 0 && i>20)
       A(i,i)=-4;
       A(i,i+1)=1;
       A(i,i-1)=1;
       A(i,i+20)=1;
       A(i,i-20)=1;
       
    else
       A(i,i)=1;
       
    end
   
end

end