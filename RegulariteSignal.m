clear all
close all

M=1010;

%Régularité = Quantification du chaos
%On va implémenter des méthodes pour estimer la régularité ie alpha € [0.5,1.5]
% alpha = 0.5 => bruit blanc
% alpha < 1.5 => mémoire courte
% alpha > 1.5 => mémoire longue


%---------------------------------
%===== INTEGRATION DE y EN Y =====
%---------------------------------

% bruit blanc gaussien
moy = 5;
var = sqrt(2);

y = moy + var*randn(1,M);
yc = y - mean(y);

Y = zeros(1,M);
Y(1) = yc(1);
for i=2:M
    Y(i) = Y(i-1) + yc(i);
end

%tracé de l'intégrale Y de y
plot(Y)

tabN = [11,13,17,21,27,35,47,59,77,101];
Fn = zeros(1,10);
count = 0;

for N = tabN
    count=count+1;    
    
    %---------------------------------------------------------
    %===== DETERMINATION DES TENDANCES DE CHAQUE FENETRE =====
    %---------------------------------------------------------
    
    L = floor(M/N);
    % params contient les coefs d'ordre 2, 1 et 0 du polynôme de degré 2
    % approchant la courbe sur la fenêtre i
    params = zeros(3,L);

    for i=1:L
        segment = Y(1,(i-1)*N+1:i*N);
        params(:,i) = polyfit((i-1)*N+1:i*N,segment,2);
    end

    estimateY = zeros(1,L*N);
    x=0;
    for i=1:L
        for j=1:N
            x=x+1;                        
            estimateY(x)=params(1,i)*x*x + params(2,i)*x + params(3,i);
        end
    end
    
    %-----------------------------------------------------
    %===== CALCUL DE LA SOMME DES CARRES DES RESIDUS =====
    %-----------------------------------------------------   
        
    R = Y(1:L*N)-estimateY;

    figure,
    subplot(2,1,1)
    plot(estimateY);
    title('tracé de estimateY')
    subplot(2,1,2)
    plot(Y)
    title('tracé de Y')

    %-----------------------------------------------------------
    %===== CALCUL DE LA RACINE DE LA PUISSANCE DES RESIDUS =====
    %-----------------------------------------------------------
    
    Fn(count)=1/(L*N)*sqrt(sum(R.^2));
end


%%
%--------------------------------------------------------------------
%===== ESTIMATION DE ALPHA AVEC REGRESSION LINEAIRE SUR log(Fn) =====
%--------------------------------------------------------------------

figure,
subplot(2,1,1)
plot(tabN,Fn);
subplot(2,1,2)
plot(log(tabN),log(Fn),'o')
title('log(Fn) en fonction de log(tabN)');

B = zeros(2,1);
B(:,1) = polyfit(log(tabN),log(Fn),1);