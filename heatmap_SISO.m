
Num_in = 128
p_vec = [1:Num_in];
U = 64;
iter = 1000
n = [1:iter];
C_fp_surf = zeros(iter,Num_in);
C_online_surf = zeros(iter,Num_in);
L_fp_surf = zeros(iter,Num_in);
L_online_surf = zeros(iter,Num_in);
for n = 1:iter
    C_fp_surf(n,:) =2.*n *(p_vec.^2 + 2);
    k_vec = floor ((p_vec-1) ./ U);
    sum = zeros(size(k_vec));
    for i = 1 : length(k_vec)
        for j = 1:k_vec(i)
            sum(i) = j*U + sum(i);
        end
    end   
    C_online_surf(n,:) = 21.*n +sum +4.* n .*(k_vec) +((p_vec - k_vec.*U).* (k_vec +1)); 
end
L_online_surf = C_online_surf .* 1./30;
L_fp_surf = C_fp_surf .* 1./170;
for i = 1:iter
    for j = 1:Num_in
        xx(i,j) = i;
        yy(i,j) =j;
    end
end


diff_one = C_online_surf - C_fp_surf;
diff_two = L_online_surf - L_fp_surf;
diff = diff_one
h = surf (xx,yy,diff);

xlabel('# of iterations','FontSize',14);
ylabel ('# of digits at output','FontSize',14);
ylim([0,128])
set(h,'LineStyle','none');
caxis([-max(max(diff)),max(max(diff))]);
bar = colorbar;
ylabel (bar,'C_{ON} - C_{SISO}','FontSize',14);
%title ('Newton'' method','FontSize',16);