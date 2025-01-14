n = 5000;
A = rand(n);
B = rand(n);
tic
C = A * B;
time = toc;
fprintf('Matrix multiplication time: %f seconds\n', time);
exit;
