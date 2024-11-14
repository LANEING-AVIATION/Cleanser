A=[1,-1,2
  -2,0,5 
  6,-3,6];
k=0;
Vk=[1
    1
    1];
for i=1:11
    P=0;
        for q=1:3
            if abs(Vk(q))>=P
                P=abs(Vk(q));
            end
        end
        Uk=Vk/P;
        k=k+1;
        Vk=A*Uk;
end
L=0;
for t=1:3
    if abs(Vk(t))>=L
        L=abs(Vk(t));
    end
end
disp(L)
disp(Uk)