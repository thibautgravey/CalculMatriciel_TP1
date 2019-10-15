%FICHIER DE TEST DYNAMIQUE

%Problème I 

%Paramètres :
PRECISION = 0.0001;
LIGNES = 20;
COLONNES = 25;
DELTAT=1;
DELAY = 0.000000000001;
TICK=0;
EPSILON = 0.01;

%Exécution
%U EST NOTRE U(t)pour t=0
[A,U]=generateSurfaceTempDynamique();

%E EST EXP DE A DELTA T (cst)
E=expm(A*DELTAT);

%FORMULE UTILISEE : U(t+dt)=E*U(t)
%AFFICHAGE 

figure(1);

while (1)
    
    if abs( max(max(U))-min(min(U))) < EPSILON
        for i=[195,215,405,425]
            U(i)=500;
            U(i+1)=500;
        end
    end 
    
   TEMP = reshape(U,LIGNES,COLONNES);
   surf(TEMP);
   U=E*U;
   TICK=TICK+1;
   pause(DELAY);
end
