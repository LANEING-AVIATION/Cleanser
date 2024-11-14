% Initial parameters
x0 = 0.7;                  % Initial guess
epsilon = 1e-7;            % Error tolerance
max_iter = 1000;           % Maximum number of iterations
f_prime_fixed = 1.179607;  % Given derivative value at x0

% Define the function f(x)
f = @(x) x * sin(x) - 0.5;

% Simplified Newton's method iteration
xk = x0;
for k = 1:max_iter
    xk1 = xk - f(xk) / f_prime_fixed  % Simplified Newton's iteration
    if abs(xk1 - xk) < epsilon         % Check convergence
        break
    end
    xk = xk1;  % Update xk
end

% Display the result
fprintf('The root near 0.7 is approximately x = %.8f after %d iterations.\n', xk1, k);
