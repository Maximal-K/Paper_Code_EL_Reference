clear
clc
close
dB = linspace(-10,15,130);
x =  10.^(dB./20);

%% N=2,β1=2/3
Q_UB_TriNomial_TwoThird = ...
    1/2-2./(3.*sqrt(2.*pi)).*x.*exp(-2./27.*x.^2)...
       -1./(3.*sqrt(2.*pi)).*x.*exp(-19./54.*x.^2);
Q_new = 1./sqrt(2.*pi).*exp(-x.^2./2)./x.*(1-1./x.^2+3./x.^4);
%%
Q_Exact = qfunc(x);

%% Chiani 
Q_UB_CDS=1/6.*exp(-2.*x.^2)+1/12*exp(-x.^2)+1/4.*exp(-x.^2./2);

%% FWK
Q_UB_FWK_2 = 1./(sqrt(2.*pi).*x).*exp(-x.^2./2)-...
     1./(2.*sqrt(2.*pi).*x).*exp(-x.^2);
Q_UB_FWK_3= Q_UB_FWK_2-1./(6.*sqrt(2.*pi).*x).*exp(-3.*x.^2);

%% Tanash20-TOC


%% Absolute error
AE_Q_UB_TriNomial_TwoThird = Q_UB_TriNomial_TwoThird-Q_Exact;
AE_Q_new = Q_new - Q_Exact;
AE_Q_UB_CDS = Q_UB_CDS - Q_Exact;
AE_Q_UB_FWK_2 = Q_UB_FWK_2 -Q_Exact;
AE_Q_UB_FWK_3 = Q_UB_FWK_3 -Q_Exact;
% AE_Q_TR_3 = qapprox-Q_Exact;

%% 绘制图像
figure
maker_idx = 1:2:length(x);
k = round(linspace(1, size(x,2), 20));

semilogy(dB, AE_Q_UB_TriNomial_TwoThird,'b')
hold on
B1 = semilogy(dB(k),AE_Q_UB_TriNomial_TwoThird(k),'b+');

semilogy(dB, AE_Q_new, 'b')
B2 = semilogy(dB(k),AE_Q_new(k),'bx');

semilogy(dB, AE_Q_UB_CDS, 'k')
B3 = semilogy(dB(k),AE_Q_UB_CDS(k),'ko-');

B4 = semilogy(dB, AE_Q_UB_FWK_2, 'k--');

B5 = semilogy(dB(k),AE_Q_UB_FWK_3(k),'ko-');



xlabel('x(dB)=20 log_{10}x')
ylabel('Absolute error')
axis([-10 15 10^(-6) 1])
legend([B1, B2, B3, B4, B5], 'Q^{(3)}_{UB-3}(x)','Q_{UB-new}(x)',...
    'Q_{UB-CDS-3}(x)','Q_{UB-FWK-2}(x)',...
    'Q_{UB-FWK-3}(x)',...
    'Location',"northeast",'fontsize',9)