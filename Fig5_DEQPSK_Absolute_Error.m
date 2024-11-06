clc
clear
close
dB=linspace(-10,20,61);
x=10.^(dB./10);

%% 
Q_QPSK = @(Q_Bound)4.*Q_Bound-8.*Q_Bound.^2+...
    8.*Q_Bound.^3-4.*Q_Bound.^4;
Exact_Q_QPSK=Q_QPSK(qfunc(sqrt(x)));

%% 
Q_UB1=@(t)1./2-1./(3.*sqrt(2.*pi)).*t.*exp(-19./54.*t.^2)-...
    2./(3.*sqrt(2.*pi)).*t.*exp(-2./27.*t.^2);
Q_UB2=@(t)1./(sqrt(2.*pi))./t.*exp(-1./2.*t.^2).*(1-1./t.^2+3./t.^4);
Q_NUB_QDPSK=[];
QUB1_AWGN_QDPSK=Q_QPSK(Q_UB1(sqrt(x)));
QUB2_AWGN_QDPSK=4.*Q_UB2(sqrt(x))-8.*Q_UB2(sqrt(x)).^2+....
                  8.*Q_UB2(sqrt(x)).^3-4.*Q_UB2(sqrt(x)).^4;
for i=1:length(x)
    if dB(i)<4.8
       Q_NUB_QDPSK(end+1)=QUB1_AWGN_QDPSK(i);
    else
       Q_NUB_QDPSK(end+1)=QUB2_AWGN_QDPSK(i);
    end
end

%% QUB-CDS-3
Q_UB_CDS=@(t)1/6.*exp(-2.*t.^2)+1/12*exp(-t.^2)+1/4.*exp(-t.^2./2);
Q_UB_CDS_QDPSK=Q_QPSK(Q_UB_CDS(sqrt(x))) ;

%% QUB-FWK-2
Q_UB_FWK_2=@(t)1./(sqrt(2*pi).*t).*exp(-1./2.*t.^2)-...
        1./(2.*sqrt(2.*pi).*t).*exp(-t.^2);
Q_UB_FWK_2_QDPSK = Q_QPSK(Q_UB_FWK_2(sqrt(x))) ;

%% QUB-FWK-3
Q_UB_FWK_3=@(t)1./(sqrt(2*pi).*t).*exp(-1./2.*t.^2)-...
        1./(2.*sqrt(2.*pi).*t).*exp(-t.^2)-...
        1./(6*sqrt(2.*pi).*t).*exp(-3.*t.^2);
Q_UB_FWK_3_QDPSK = Q_QPSK(Q_UB_FWK_3(sqrt(x))) ;

%% Absolute Error
AE_Q_NUB_QDPSK=Q_NUB_QDPSK-Exact_Q_QPSK;
AE_Q_CH_UB_1_QDPSK=Q_UB_CDS_QDPSK-Exact_Q_QPSK;
AE_Q_UB_FWK_2_QDPSK=Q_UB_FWK_2_QDPSK-Exact_Q_QPSK;
AE_Q_UB_FWK_3_QDPSK=Q_UB_FWK_3_QDPSK-Exact_Q_QPSK;

%% Tanash20-TOC

%% print
set(figure,'Color','w')
set (gca,'XAxisLocation','bottom'); 
subplot('Position',[0.1,0.11,0.4,0.8])
semilogy(dB,AE_Q_NUB_QDPSK,'b-o','MarkerSize',4);
hold on
semilogy(dB,AE_Q_CH_UB_1_QDPSK,'k-o','MarkerSize',4);
semilogy(dB,AE_Q_UB_FWK_2_QDPSK,'k--');
semilogy(dB,AE_Q_UB_FWK_3_QDPSK,'ko','MarkerSize',4);
semilogy(dB,AE_Q_UB_FWK_3_QDPSK,'ko','MarkerSize',4);

ylabel('Absolute error');
axis([-8 3 10^(-5) 0.2])
%set(gca,'Box','off')

subplot('Position',[0.55,0.11,0.4,0.8])
p1=semilogy(dB,AE_Q_NUB_QDPSK,'b-o','MarkerSize',4);
hold on
p2=semilogy(dB,AE_Q_CH_UB_1_QDPSK,'k-o','MarkerSize',4);
p3=semilogy(dB,AE_Q_UB_FWK_2_QDPSK,'k--');
p4=semilogy(dB,AE_Q_UB_FWK_3_QDPSK,'ko','MarkerSize',4);
axis([8 16 10^(-10) 0.1])

legend([p1 p2 p3 p4],{'Q_{UB}(x)','Q_{UB-CDS-3}(x)',...
    'Q_{UB-FWK-2}(x)','Q_{UB-FWK-3}(x)'},...
    'Location',"northeast",'fontsize',8)
xlabel('SNR(dB)');
