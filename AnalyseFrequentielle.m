clear all
close all

%Représentations temporelle et temps-fréquence de 2 signaux de taille M

%on ne traite pas les signaux stationnaires et non sttionnaires de la même
%façon : on fait en premier lieu un spectrogramme pour le déterminer.

%quand on traite un signal, on le recentre pour nétudier ses variations

%un signal est stationnaire si son contenu fréquentiel est constant
%puissance d'un bruit blanc = sa variance
%un offset se traduit par un forte composante en 0 ie dans les basses
%fréquences -> cas 2
M=1010;

%Cas 1 - Bruit Blanc Gaussien Centré
moy1 = 0;
var1 = 1;
y1 = moy1 + var1*randn(1,M);

subplot(2,1,1)
plot(y1);
title('Représentation fréquentielle du bruit blanc Gaussien centré')
xlabel('temps') 
ylabel('fréquence')
axis([0 1010 -5 5])

subplot(2,1,2)
s1 = spectrogram(y1,sqrt(M));
imagesc(abs(s1))
title('Bruit Blanc Centré')
xlabel('fenêtre')
ylabel('fréquence')
colorbar

%Cas 2 - Bruit Blanc Gaussien Non Centré
moy2 = 5;
var2 = sqrt(2);
y2 = moy2 + var2*randn(1,M);

figure
subplot(2,1,1)
plot(y2);
title('Représentation fréquentielle du bruit blanc Gaussien non centré')
xlabel('temps') 
ylabel('fréquence')
axis([0 1010 0 10])

subplot(2,1,2)
s2 = spectrogram(y2,sqrt(M));
imagesc(abs(s2))
title('Spectrogramme Bruit Blanc Non Centré')
xlabel('fenêtre') 
ylabel('fréquence')
colorbar

%histogramme des fréquences
