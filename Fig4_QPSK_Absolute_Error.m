clear
clc
close
syms t n
dB=linspace(-10,16,50);
x=10.^(dB./10);

%%
Q_QPSK = @(Q_Bound)2.*Q_Bound-Q_Bound.^2;
%% Q_UB_CDS
Q_UB_CDS = @(t)1/6.*exp(-2.*t.^2)+1/12*exp(-t.^2)+1/4.*exp(-t.^2./2);          %Q_{UB-CDS-3}(x)
Q_UB_CDS_QPSK = Q_QPSK(Q_UB_CDS(sqrt(x)));
%% Q_UB_FWK_2
Q_UB_FWK_2=@(t)1./(sqrt(2.*pi).*t).*exp(-t.^2./2)-...
    1./(2.*sqrt(2.*pi).*t).*exp(-t.^2);
Q_UB_FWK_2_QPSK = Q_QPSK(Q_UB_FWK_2(sqrt(x)));
%% Q_UB_FWK_3
Q_UB_FWK_3=@(t)Q_UB_FWK_2(sqrt(x))-1./(6.*sqrt(2.*pi).*t).*exp(-3.*t.^2);
Q_UB_FWK_3_QPSK = Q_QPSK(Q_UB_FWK_3(sqrt(x)));
%% Q_New
Q_UB1=@(t)1./2-1./(3.*sqrt(2.*pi)).*t.*exp(-19./54.*t.^2)-...
    2./(3.*sqrt(2.*pi)).*t.*exp(-2./27.*t.^2);
Q_UB2=@(t)1./(sqrt(2.*pi))./t.*exp(-1./2.*t.^2).*(1-1./t.^2+3./t.^4);
Q_NUB_QDPSK=[];
QUB1_AWGN_QDPSK=Q_QPSK(Q_UB1(sqrt(x)));
QUB2_AWGN_QDPSK=Q_QPSK(Q_UB2(sqrt(x)));

for i=1:length(x)
    if dB(i)<4.8
       Q_NUB_QDPSK(end+1)=QUB1_AWGN_QDPSK(i);
    else
       Q_NUB_QDPSK(end+1)=QUB2_AWGN_QDPSK(i);
    end
end

%%
Exact_Q_QPSK=Q_QPSK(qfunc(sqrt(x)));


AE_Q_UB_FWK_2_QPSK=Q_UB_FWK_2_QPSK-Exact_Q_QPSK;
AE_Q_UB_FWK_3_QPSK=Q_UB_FWK_3_QPSK-Exact_Q_QPSK;
AE_Q_UB_CDS_QPSK = Q_UB_CDS_QPSK-Exact_Q_QPSK;
AE_Q_NUB_QDPSK= Q_NUB_QDPSK-Exact_Q_QPSK;
%% Tanash20-TOC
% error_type='absolute_error';
% function_Q='p_1';
% variation='upper_bounds';
% N=3;
% right_end_point=6;%only for relative error
% [a,b]=func_extract_coef(error_type,function_Q,variation,N,right_end_point);
% p=1;
% qapprox=0;
% for i=1:N
%     qapprox=qapprox+(a(i).*exp(-(b(i)).*x.^2));
% end
% T=2.*qapprox-qapprox.^2;
% jt=(T-P);

%%
set(figure,'Color','w')
set (gca,'XAxisLocation','bottom'); 
subplot('Position',[0.1,0.11,0.4,0.8])
% subplot(1,2,1)
% xlabel('SNR(dB)')
semilogy(dB,AE_Q_NUB_QDPSK,'b-o','MarkerSize',4)
hold on
semilogy(dB,AE_Q_UB_CDS_QPSK,'k-o','MarkerSize',4)
semilogy(dB,AE_Q_UB_FWK_2_QPSK,'k--')
semilogy(dB,AE_Q_UB_FWK_3_QPSK,'ko','MarkerSize',4)
% semilogy(dB,jt,'k-^','MarkerSize',5)
% semilogy(x,P2,'k-o')
ylabel('Absolute error')
axis([-8 2 10^(-5) 0.2])
%set(gca,'Box','off')

% subplot(1,2,2)
subplot('Position',[0.55,0.11,0.4,0.8])
semilogy(dB,AE_Q_NUB_QDPSK,'b-o','MarkerSize',4)
hold on
semilogy(dB,AE_Q_UB_CDS_QPSK,'k-o','MarkerSize',4)
semilogy(dB,AE_Q_UB_FWK_2_QPSK,'k--')
semilogy(dB,AE_Q_UB_FWK_3_QPSK,'ko','MarkerSize',4)
% semilogy(dB,jt,'k-^','MarkerSize',5)
%set(gca,'yaxislocation','right');
% semilogy(x,P2,'k-o')
axis([8 15 10^(-8) 10^(-2)])
%set(gca,'Box','off')
xlabel('SNR(dB)')
legend('Q_{UB}(x)','Q_{UB-CDS-3}(x)','Q_{UB-FWK-2}(x)',...
    'Q_{UB-FWK-3}(x)','Location',"northeast",'fontsize',6)

%linkaxes([ax1,ax2],'x');
