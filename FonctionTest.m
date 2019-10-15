%FICHIER DE TEST STATIQUE

%Paramètres :
PRECISION = 0.0001;
LIGNES = 20;
COLONNES = 25;

%Exécution
[A,B]=generateSurfaceTemp();

[X1,E1,LIMIT1]=Jacobi(A,B,PRECISION);
[X2,E2,LIMIT2]=GaussSeidel(A,B,PRECISION);
[X3,E3,LIMIT3]=relaxation(A,B,PRECISION);

TEMP = reshape(X3,LIGNES,COLONNES);

figure(1);
surf(TEMP);
 

