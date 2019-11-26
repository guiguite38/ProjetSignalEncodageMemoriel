clear all
close all

M=1000;

%R�gularit� = Quantification du chaos
%On va impl�menter des m�thodes pour estimer la r�gularit� ie alpha � [0.5,1.5]
% alpha = 0.5 => bruit blanc
% alpha < 1.5 => m�moire courte
% alpha > 1.5 => m�moire longue

%%Processus
% on int�gre le signal : y => Y

moy = 5;
var = sqrt(2);

y = moy + var*randn(1,M);
yc = y - mean(y);

Y = zeros(1,M);
Y(1) = yc(1);
for i=2:M
    Y(i) = Y(i-1) + yc(i);
end

%Int�grale
plot(Y)

nbFenetres = 10;
% params contient les coefs d'ordre 2, 1 et 0 du polyn�me de degr� 2
% approchant la courbe sur la fen�tre i
params = zeros(3,nbFenetres-1);

for i=1:9
    segment = Y(1,i*M/nbFenetres:(i+1)*M/nbFenetres);
    params(:,i) = polyfit(i*M/nbFenetres:(i+1)*M/nbFenetres,segment,2); 
end

% fen�trage => on a une tendance par fen�tre
% calcul r�sidus # r�sidu d'une fen�tre = Somme(|signal-tendance|)

%on trace log(F(n))
% N le nombre de fen�tres
% F(N) l'amplitude carr�e normalis�e #on enl�ve la moyenne