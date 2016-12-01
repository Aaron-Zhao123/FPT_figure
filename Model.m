close all, clc, clear all;
Num_in = 128;

p_vec = [1:Num_in];
U = 64;
n = [10;50;100];
p_discrete = [8,16,32,64,128];
C_fp = 6 .* n * p_vec;
C_fp_discrete = 6 .* n * p_discrete;
C_fp_SISO = 2.*n *(p_vec.^2 + 2);
for i = 1:3
L_fp(i,:) = C_fp_discrete(i,:) .* 1./[185 139.63 110 76 46];
end
L_fp_SISO = C_fp_SISO ./ 4000;
k_vec = floor (p_vec ./ U);
sum = zeros(size(k_vec));
for i = 1 : length(k_vec)
    for j = 1:k_vec(i)
        sum(i) = j*U + sum(i);
    end
end
for i = 1:3
    tmp = 4.*ones (size(n,1),1)*k_vec .*n(i);
end
C_online = 21.*n * ones(1,Num_in) + ones(size(n)) * sum + tmp + ones (size(n,1),1) * ((p_vec - k_vec.*U).* (k_vec +1)); 
L_online = C_online .* 1./30;


txt1 = strcat('Iter ' , num2str(n));
offset_x = 10;
offset_y = 100;
figure
subplot(2,1,1)
for i = 1:size(n,1)
   % plot(p_vec, C_fp(i,:),'--r','LineWidth',2 ); hold on
    fig1 = plot(p_vec, C_online(i,:),'b','LineWidth',2); hold on
    fig3 = plot(p_vec, C_fp_SISO(i,:),'-.r','LineWidth',2); hold on

    %text(p_vec(round(Num_in))*1.01,C_fp(i,round(Num_in)),txt1(i,:),'FontSize',12); hold on
    text(p_vec(round(Num_in))*1.01,C_online(i,round(Num_in)),txt1(i,:),'FontSize',12); hold on
    text(p_vec(round(Num_in))*1.01,C_fp_SISO(i,round(Num_in)),txt1(i,:),'FontSize',12); hold on
end
hold off
    %plot(p_vec, L_fp, 'r', p_vec, L_online,'b');
ylabel ('# clock cycles','FontSize',16);
xlabel ('# digit at output','FontSize',16);
fig_legend = legend ([fig3,fig1],'fp\_SISO','online');
set(fig_legend,'FontSize',12)
set(gcf(), 'Renderer', 'painters');
set(gca,'yscale','log');
set(gca, 'FontSize', 12);
xlim([8,140])
grid on
subplot(2,1,2)
for i = 1:size(n,1)
    fig1 = plot(p_vec, L_online(i,:),'b','LineWidth',2); hold on
    if i== 1
        text(p_vec(round(Num_in))*0.9,L_online(i,round(Num_in))*0.9,txt1(i,:),'FontSize',12); hold on
    end
    if i== 2
        text(p_vec(round(Num_in))*0.9,L_online(i,round(Num_in))*1.05,txt1(i,:),'FontSize',12); hold on
    end
    if i ==3
        text(p_vec(round(Num_in))*0.9,L_online(i,round(Num_in))*1.1,txt1(i,:),'FontSize',12); hold on
    end
    fig3 = plot(p_vec, L_fp_SISO(i,:),'-.r','LineWidth',2); hold on
    text(p_vec(round(Num_in))*1,L_fp_SISO(i,round(Num_in)),txt1(i,:),'FontSize',12); hold on
end
for i =1 : 3
    %fig2 = plot(p_discrete, L_fp(i,:),'--r','LineWidth',2 ); hold on
    %text(p_discrete(round(5))*1.01,L_fp(i,round(5)),txt1(i,:),'FontSize',12); hold on
end
hold off
    %plot(p_vec, L_fp, 'r', p_vec, L_online,'b');
ylabel ('Latency (\mus)','FontSize',16);
xlabel ('# digit at output','FontSize',16);
set(gca,'yscale','log');

fig_legend = legend ([fig3,fig1],'fp\_SISO','online');
set(fig_legend,'FontSize',12)
set(gcf(), 'Renderer', 'painters');
set(gca, 'FontSize', 12);
grid on
xlim([8,140])


