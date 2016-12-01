close all
num_bits = [8,16,32,64, 128];
fp_cycle = [276	508	972 2224 4400];
F_max_fp = [185 139.63	110	76 46];
LE_fp = [1648 2964 5364 9762 20574];


online_cycle = [201	217	233	265	394];
F_max_online = 54.4;
LE_online = 64122*ones(1,5);

Latency_fp = fp_cycle.*1./F_max_fp;
Latency_online = online_cycle.*1./F_max_online;
figure
%subplot(3,1,1)
%plot(num_bits,fp_cycle);
%hold on
%plot(num_bits,online_cycle);
%xlim([8,128])
%set(gca,'yscale','log');
%grid on
subplot(3,1,1)
plot(num_bits,Latency_fp,'--ob','LineWidth',2);
hold on
plot(num_bits,Latency_online,'-xr','LineWidth',2);
legend('Fixed Point', 'Online');
xlim([8,128])
xlabel('# digits at output','FontSize',14)
ylabel('Latency (\mus)','FontSize',14)
set(gca,'yscale','log');
grid on
subplot(3,1,2)
plot(num_bits,LE_fp,'--ob','LineWidth',2);
hold on
plot(num_bits,LE_online,'-xr','LineWidth',2);
xlim([8,128])
ylim([1000,1000000])
legend('Fixed Point', 'Online');
xlabel('# digits at output','FontSize',14)
ylabel('LEs','FontSize',14)
set(gca,'yscale','log');
grid on
subplot(3,1,3)
plot(num_bits,LE_fp.*Latency_fp,'--ob','LineWidth',2);
hold on
plot(num_bits,LE_online.*Latency_online,'-xr','LineWidth',2);
legend('Fixed Point', 'Online');
xlim([8,128])
ylim([10^3,10^7])
set(gca,'yscale','log');
grid on
xlabel('# digits at output','FontSize',14)
ylabel('LEs * Latency (\us)','FontSize',14)