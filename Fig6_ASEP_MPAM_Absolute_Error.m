clc
clear
syms X
Gamma=linspace(-10,25,71);
x=10.^(Gamma./10);
sigma=2;
M=2;
Mu=(log(x)-log(10).^2./200.*sigma^2).*10./log(10);

%%
Constant=@(M,sigma)40.*(M-1)./log(10)./(M.*sqrt(2.*pi.*sigma.^2));
step=0.01;
Q_MPAP=[];
for i=1:length(Mu)
    y=0;
    for t=0.00001:step:1000
        y=((qfunc(t))./t.*exp(-(20.*log10(t)+10.*...
            log10((M.^2-1)./6)-Mu(i)).^2./2./sigma.^2)).*step+y;
    end
    Q_MPAP(end+1)=Constant(2,2).*y;
end

%%
Q_NUB1=@(t)1./2-1./(3.*sqrt(2*pi)).*t.*exp(-19./54*t.^2)-...
        2./(3.*sqrt(2*pi)).*t.*exp(-2./27*t.^2);
Q_NUB2=@(temp)1./sqrt(2.*pi).*exp(-temp.^2./2)./temp.*...
        (1-1./temp.^2+3./temp.^4);
Q_NUB1_MPAM=[];
for i=1:length(Mu)
    y=0;
    M=2;
    sigma=2;
    Mu=(log(x)-log(10).^2./200.*sigma^2).*10./log(10);
    for t=0.001:step:1000
        y=((Q_NUB1(t))./t.*exp(-(20.*log10(t)+10.*...
            log10((M.^2-1)./6)-Mu(i)).^2./2./sigma.^2)).*step+y;
    end
    Q_NUB1_MPAM(i)=Constant(2,2).*y;
end
Q_NUB2_MPAM=[];
for i=1:length(Mu)
    y=0;
    M=2;
    sigma=2;
    Mu=(log(x)-log(10).^2./200.*sigma^2).*10./log(10);
    for t=0.001:step:1000
        y=((Q_NUB2(t))./t.*exp(-(20.*log10(t)+10.*...
            log10((M.^2-1)./6)-Mu(i)).^2./2./sigma.^2)).*step+y;
    end
    Q_NUB2_MPAM(i)=Constant(2,2).*y;
end

%% Chiani 
Q_UB_CDS_1=@(t)1/6.*exp(-2.*t.^2)+1/12*exp(-t.^2)+1/4.*exp(-t.^2./2);
Q_UB_CDS_MPAM=[];
for i=1:length(Mu)
    y=0;
    M=2;
    sigma=2;
    Mu=(log(x)-log(10).^2./200.*sigma^2).*10./log(10);
    for t=0.00001:step:1000
        y=((Q_UB_CDS_1(t))./t.*exp(-(20.*log10(t)+10.*...
            log10((M.^2-1)./6)-Mu(i)).^2./2./sigma.^2)).*step+y;
    end
    Q_UB_CDS_MPAM(end+1)=Constant(2,2).*y;
end

%% FWK
Q_UB_FWK_2=@(t)1./(sqrt(2*pi).*t).*exp(-1./2.*t.^2)-...
        1./(2.*sqrt(2.*pi).*t).*exp(-t.^2);
Q_UB_FWK_2_MPAM=[];
for i=1:length(Mu)
    y=0;
    M=2;
    sigma=2;
    Mu=(log(x)-log(10).^2./200.*sigma^2).*10./log(10);
    for t=0.00001:step:1000
        y=((Q_UB_FWK_2(t))./t.*exp(-(20.*log10(t)+10.*...
            log10((M.^2-1)./6)-Mu(i)).^2./2./sigma.^2)).*step+y;
    end
    Q_UB_FWK_2_MPAM(end+1)=Constant(2,2).*y;
end

%% FWK
Q_UB_FWK_3=@(t)1./(sqrt(2*pi).*t).*exp(-1./2.*t.^2)-...
        1./(2.*sqrt(2.*pi).*t).*exp(-t.^2)-...
        1./(6*sqrt(2.*pi).*t).*exp(-3.*t.^2);
    Q_UB_FWK_3_MPAM=[];
for i=1:length(Mu)
    y=0;
    for t=0.00001:step:1000
        y=((Q_UB_FWK_3(t))./t.*exp(-(20.*log10(t)+10.*...
            log10((M.^2-1)./6)-Mu(i)).^2./2./sigma.^2)).*step+y;
    end
    Q_UB_FWK_3_MPAM(end+1)=Constant(2,2).*y;
end

%%
AE_Q_NUB1_MPAM=Q_NUB1_MPAM-Q_MPAP;
AE_Q_NUB2_MPAM=Q_NUB2_MPAM-Q_MPAP;
AE_Q_UB_CDS_MPAM=Q_UB_CDS_MPAM-Q_MPAP;
AE_Q_UB_FWK_2_MPAM=Q_UB_FWK_2_MPAM-Q_MPAP;
AE_Q_UB_FWK_3_MPAM=Q_UB_FWK_3_MPAM-Q_MPAP;

%% Tanash20-TOC

%%
set(figure,'Color','w')
set (gca,'XAxisLocation','bottom'); 
subplot('Position',[0.1,0.11,0.4,0.8])
semilogy(Gamma,AE_Q_NUB1_MPAM,'b-o','MarkerSize',4);
hold on
semilogy(Gamma,AE_Q_UB_CDS_MPAM,'k-o','MarkerSize',4);
semilogy(Gamma,AE_Q_UB_FWK_2_MPAM,'k--');
semilogy(Gamma,AE_Q_UB_FWK_3_MPAM,'ko','MarkerSize',4); 

axis([-10 -1 10^(-5) 0.2]);
%set(gca,'Box','off')
ylabel('Absolute error')

subplot('Position',[0.55,0.11,0.4,0.8])
p1=semilogy(Gamma,AE_Q_NUB2_MPAM,'b-o','MarkerSize',4);
hold on
p2=semilogy(Gamma,AE_Q_UB_CDS_MPAM,'k-o','MarkerSize',4);
p3=semilogy(Gamma,AE_Q_UB_FWK_2_MPAM,'k--');
p4=semilogy(Gamma,AE_Q_UB_FWK_3_MPAM,'ko','MarkerSize',4);

axis([10 20 10^(-12) 10.^(-3)]);
xlabel('Γ(dB)');
legend([p1 p2 p3 p4],{'Q_{UB}(x)','Q_{UB-CDS-3}(x)',...
    'Q_{UB-FWK-2}(x)','Q_{UB-FWK-3}(x)'},...
    'Location',"northeast",'fontsize',8)
%set(gca,'Box','off')
%set(gca,'yaxislocation','right');
