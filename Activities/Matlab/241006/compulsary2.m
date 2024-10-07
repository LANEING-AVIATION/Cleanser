function solve_equation_system()
    % 定义方程组，使用匿名函数
    equations = @(vars) [
        vars(1) + vars(2)^2 - 13;           % 第一个方程: x + y^2 = 13
        log(2*vars(1) + vars(2)) - vars(1)^vars(2) + 2  % 第二个方程: ln(2x + y) - x^y = -2
    ];

    % 设置初值（可以更改来验证初值的影响）
    initial_guess = [1, 2];  % 初值 [x, y]

    % 使用 fsolve 求解方程组
    options = optimset('Display', 'iter');  % 显示迭代信息
    [solution, fval, exitflag] = fsolve(equations, initial_guess, options);

    % 显示结果
    if exitflag > 0
        disp('求解成功:');
        disp(['x = ', num2str(solution(1))]);
        disp(['y = ', num2str(solution(2))]);
    else
        disp('求解未成功，请尝试不同的初值。');
    end

    % 验证初值的影响，可以更改初值重复运行该代码。
end
