g = @(x) 0.5 - (x^5 + 1) / 5; % 改写形式
x0 = 0; 
tol = 1e-6; 
max_iter = 100;

for iter = 1:max_iter
    x1 = g(x0);
    if abs(x1 - x0) < tol
        break;
    end
    x0 = x1;
end
disp(x1);
