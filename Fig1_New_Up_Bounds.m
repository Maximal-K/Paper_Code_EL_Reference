clear
clc
close
dB=linspace(-10,22,130);
x=10.^(dB./20);

%% N=1
Q_UB_BioNomial=1/2-1./sqrt(2.*pi).*x.*exp(-1./6.*x.^2);

%% N=2,β1=1/3
Q_UB_TriNomial_OneHalf=...
    1/2-1./(3.*sqrt(2.*pi)).*x.*exp(-1./54.*x.^2)...
       -2./(3.*sqrt(2.*pi)).*x.*exp(-13./54.*x.^2);

%% N=2,β1=1/2
Q_UB_TriNomial_OneThird = ...
    1/2-1./(2.*sqrt(2.*pi)).*x.*exp(-1./24.*x.^2)...
       -1./(2.*sqrt(2.*pi)).*x.*exp(-7./24.*x.^2);

%% N=2,β1=2/3
Q_UB_TriNomial_TwoThird= ...
    1/2-2./(3.*sqrt(2.*pi)).*x.*exp(-2./27.*x.^2)...
       -1./(3.*sqrt(2.*pi)).*x.*exp(-19./54.*x.^2);

%% N=3,β1=1/3,β2=2/3
Q_UB_FourNomial_OneThird_TwoThird= ...
    1/2-1./(3.*sqrt(2.*pi)).*x.*exp(-1./54.*x.^2)...
       -1./(3.*sqrt(2.*pi)).*x.*exp(-7./54.*x.^2)...
       -1./(3.*sqrt(2.*pi)).*x.*exp(-19./54.*x.^2);

%%
Q_Exact=qfunc(x);
f1=1/6*exp(-2.*x.^2)+1/6*exp(-2/3.*x.^2)+1/6*exp(-1/2*x.^2);

%% Absolute error
AE_Q_UB_BioNomial = Q_UB_BioNomial-Q_Exact;
AE_Q_UB_TriNomial_OneHalf = Q_UB_TriNomial_OneHalf-Q_Exact;
AE_Q_UB_TriNomial_OneThird = Q_UB_TriNomial_OneThird-Q_Exact;
AE_Q_UB_TriNomial_TwoThird = Q_UB_TriNomial_TwoThird-Q_Exact;
AE_Q_UB_FourNomial_OneThird_TwoThird = Q_UB_FourNomial_OneThird_TwoThird-Q_Exact;
j6 = f1-Q_Exact;

%% 绘制图像
figure
maker_idx = 1:2:length(x);
k = round(linspace(1, size(x,2), 25));

semilogy(dB,AE_Q_UB_BioNomial,'b')
hold on
B1 = semilogy(dB(k),AE_Q_UB_BioNomial(k),'b.-');

semilogy(dB, AE_Q_UB_TriNomial_OneHalf, 'b')
B2 = semilogy(dB(k),AE_Q_UB_TriNomial_OneHalf(k),'b--');

semilogy(dB, AE_Q_UB_TriNomial_OneThird, 'b-')
B3 = semilogy(dB(k),AE_Q_UB_TriNomial_OneThird(k),'b-');

semilogy(dB, AE_Q_UB_TriNomial_TwoThird, 'b')
B4 = semilogy(dB(k),AE_Q_UB_TriNomial_TwoThird(k),'b-+');

semilogy(dB, AE_Q_UB_FourNomial_OneThird_TwoThird, 'b')
B5 = semilogy(dB(k),AE_Q_UB_FourNomial_OneThird_TwoThird(k),'b-x');

xlabel('x(dB)=20 log_{10}x')
ylabel('Absolute error')
axis([-10 10 10^(-6) 0.1])
legend([B1, B2, B3, B4, B5], 'Q_{UB-2}(x)','Q_{UB-3}^{(1)}(x) with β_{1}=1/3, β_{2}=1',...
    'Q_{UB-3}^{(2)}(x) with β_{1}=1/2, β_{2}=1',...
    'Q_{UB-3}^{(3)}(x) with β_{1}=2/3, β_{2}=1',...
    'Q_{UB-4}(x) with β_{1}=1/3, β_{2}=2/3, β_{3}=1',...
    'Location',"southeast",'fontsize',7)