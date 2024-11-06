clc;
clear;
close
dB=linspace(-10,4,30);
x=10.^(dB/20);

%% orginal function
Exact_Q = qfunc(x);
Q_UB_BioNomial = 1./2-1./sqrt(2.*pi).*x.*exp(-1./6.*x.^2);
Q_UB_CDS_3=1/6*exp(-2.*x.^2)+1/6*exp(-2/3.*x.^2)+1/6*exp(-1/2*x.^2);
Q_FKW_2=1./(sqrt(2.*pi).*x).*exp(-x.^2./2)-1./(2.*sqrt(2.*pi).*x).*exp(-x.^2);
Q_UB_FKW_3=Q_FKW_2-1./(6.*sqrt(2.*pi).*x).*exp(-3.*x.^2);
f=sqrt(x.^4+6.*x.^2+1);
Q_Wu18_CL=sqrt(exp(1)/pi).*sqrt(f+x.^2+1)./(f+x.^2+3).*exp(-(f+x.^2-1)./4);

%%
figure
Q=semilogy(dB,Exact_Q,'r');
hold on
B1=semilogy(dB,Q_UB_BioNomial,'b.-','MarkerSize',8);
B2=semilogy(dB,Q_UB_CDS_3,'k-o','MarkerSize',4);
B3=semilogy(dB,Q_FKW_2,'k--');
B4=semilogy(dB,Q_UB_FKW_3,'ko','MarkerSize',4);
B5=semilogy(dB,Q_Wu18_CL,'k-x');
% yt=semilogy(x_dB,qapprox,'k-^','MarkerIndices',1:20:length(x_range), ...
%     'MarkerSize',5);
legend([Q, B1, B2, B3, B4, B5],{'exact Q(x)','Q_{UB-2}(x)','Q_{UB-CDS-3}(x)',...
    'Q_{UB-FWK-2}(x)','Q_{UB-FWK-3}(x)','Q_{LB-WLG}(x)'},...
    'Location','southwest')
axis([-3 0.5 0.15 0.24]);
t=0:0:0; 
% set (gca,'xtick',t); 
% set (gca,'ytick',t); 
xlabel('x(dB)=20 log_{10}x')
ylabel('Q(x)')

% 创建 line
annotation('line',[0.13125 0.903571428571429],[0.486 0.486],...
    'Color',[0 0 1],...
    'LineStyle','-.');

% 创建 textbox
annotation('textbox',...
    [0.0973214285714283 0.454761904761906 0.0339285714285716 0.064476190476191],...
    'String','y',...
    'LineStyle','none',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% 创建 line
annotation('line',[0.572321428571429 0.572321428571429],...
    [0.485904761904762 0.115476190476191],'Color',[0 0 1],'LineStyle','-.');

% 创建 line
annotation('line',[0.591071428571428 0.591071428571428],...
    [0.487095238095239 0.116666666666667],'Color',[0 0 1],'LineStyle','-.');

% 创建 textbox
annotation('textbox',...
    [0.538392857142853 0.0750000000000013 0.117857142857146 0.0559523809523822],...
    'String','x_{1}    x_{2}',...
    'LineStyle','none',...
    'FontSize',8,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);
