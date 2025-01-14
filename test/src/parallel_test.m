pool = parpool('local');
n = 1000;
A = distributed(rand(n));
B = distributed(rand(n));
tic
C = A * B;
time = toc;
fprintf('Parallel computation time: %f seconds\n', time);
delete(pool);
exit;
