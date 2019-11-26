clear all
close all

%Repr�sentations temporelle et temps-fr�quence de 2 signaux de taille M

%on ne traite pas les signaux stationnaires et non sttionnaires de la m�me
%fa�on : on fait en premier lieu un spectrogramme pour le d�terminer.

%quand on traite un signal, on le recentre pour n�tudier ses variations

%un signal est stationnaire si son contenu fr�quentiel est constant
%puissance d'un bruit blanc = sa variance
%un offset se traduit par un forte composante en 0 ie dans les basses
%fr�quences -> cas 2
M=1010;

%Cas 1 - Bruit Blanc Gaussien Centr�
moy1 = 0;
var1 = 1;
y1 = moy1 + var1*randn(1,M);

subplot(2,1,1)
plot(y1);
title('Repr�sentation fr�quentielle du bruit blanc Gaussien centr�')
xlabel('temps') 
ylabel('fr�quence')
axis([0 1010 -5 5])

subplot(2,1,2)
s1 = spectrogram(y1,sqrt(M));
imagesc(abs(s1))
title('Bruit Blanc Centr�')
xlabel('fen�tre')
ylabel('fr�quence')
colorbar

%Cas 2 - Bruit Blanc Gaussien Non Centr�
moy2 = 5;
var2 = sqrt(2);
y2 = moy2 + var2*randn(1,M);

figure
subplot(2,1,1)
plot(y2);
title('Repr�sentation fr�quentielle du bruit blanc Gaussien non centr�')
xlabel('temps') 
ylabel('fr�quence')
axis([0 1010 0 10])

subplot(2,1,2)
s2 = spectrogram(y2,sqrt(M));
imagesc(abs(s2))
title('Spectrogramme Bruit Blanc Non Centr�')
xlabel('fen�tre') 
ylabel('fr�quence')
colorbar

%histogramme des fr�quences
