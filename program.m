addpath(genpath(pwd));
savepath();
close('all');
clear;

[headers,User_ID,X] = readData();
[l,N] = size(X);
% vriskoume tis min/max apostaseis meta3y twn dianysmatwn tou X
mind = Inf;
maxd = 0;
for i = 1:N
    for j = (i+1):N
        d = sqrt(sum((X(:,i)-X(:,j)).^2)); %euklideia
        if d < mind
          mind = d;
        elseif d > maxd
          maxd = d;
        endif
    endfor
endfor

% ypologismos eurous tou katwfliou apostashs theta
n_theta = 60;
theta_min = mind + (maxd-mind)/4;
theta_max = maxd - (maxd-mind)/4; % euros pera autou de parexei arketh plhroforia
theta_range = linspace(theta_min, theta_max, n_theta);

% efarmozoume n_times fores ton BSAS gia ka8e timh tou theta
n_times = 7;
q = N; % orizoume ws anwfli plh8ous klasewn enan mh perioristiko ari8mo
m_total = []; % plh8os klasewn pou proekypse apo ka8e timh tou theta
for theta = theta_range
    list_m = zeros(1, q); % poses fores emfanisthke to ka8e plh8os klasewn
    for stat = 1:n_times
        order = randperm(N); % tyxaia seira eisodwn twn dianysmatwn
        [~, repre] = BSAS(X,theta,q,order);
        k = size(repre,2); % plh8os twn klasewn poy proekypsan
        list_m(k) = list_m(k)+1;
    endfor
    [~, m_size] = max(list_m); % pio plh8os proekypse tis perissoteres fores
    m_total = [m_total m_size];
endfor

plot(theta_range, m_total, '-o');
title("Number of clusters for each value of Theta");
xlabel("Distance threshold (Theta)");
ylabel("Number of clusters");
