% Convert the entire code to Matlab code

maxp = 5;
a = zeros(1, 50);
temp = zeros(1, 70);
temp2 = zeros(1, 70);
t = 0;
i = 0;
j = 0;
k = 0;
nd = 0;
n = 0;
nh = 0;
sum = 0;
pos = 0;

nd = input('Enter Length of Data String: ');
disp('Enter Data String: ');
for i = 1:nd
    a(i) = input('');
end
disp('-----------------------------------');
for i = 1:nd
    for k = 0:maxp-1
        t = 2^k - 1;
        if j == t
            temp(j+1) = 0;
            j = j + 1;
        end
    end
    temp(j+1) = a(i);
    j = j + 1;
end
nh = j;
fprintf('Length of Hamming code: %d bits\n', nh);
n = nh - nd;
fprintf('Number of Parity Bits: %d \n', n);

b = zeros(1, n);
m = n - 1;
for k = 0:n-1
    t = 2^k - 1;
    i = t;
    while i < nh
        for j = 0:t
            sum = sum + temp(i+1);
            i = i + 1;
            if i >= nh
                break;
            end
        end
        if i >= nh
            break;
        end
        for j = 0:t
            i = i + 1;
            if i >= nh
                break;
            end
        end
        if i >= nh
            break;
        end
    end
    temp(t+1) = mod(sum, 2);
    sum = 0;
    fprintf('P%d: %d\n', t+1, temp(t+1));
end

fprintf('\nHamming code: Sender side:   ');
for i = 1:nh
    fprintf('%d ', temp(i));
end

fprintf('\nHamming code: Receiver side: ');
for i = 1:nh
    temp2(i) = input('');
end
sum = 0;
m = n;
    b = zeros(1, n);
    pos = 0;

    for k = 0:n-1
        t = 2^k - 1;

        for i = t+1:nh
            for j = 1:t+1
                sum = sum + temp2(i);
                i = i + 1;
                if i >= nh
                    break;
                end
            end

            if i >= nh
                break;
            end

            for j = 1:t+1
                i = i + 1;
                if i >= nh
                    break;
                end
            end

            if i >= nh
                break;
            end
        end
        b(m) = mod(sum, 2);
        sum = 0;
        fprintf('P%d: %d\n', t+1, b(m));
        m = m - 1;
    end

    for m = 1:n
        pos = pos + b(n-m+1) * 2^(m-1);
    end
    fprintf('Position of Error: %d\n', pos);
    if temp2(pos) == 0
        temp2(pos) = 1;
    else
        temp2(pos) = 0;
    end

    fprintf('\nHamming code: Receiver side: Error Corrected:  ');
    for i = 1:nh
        fprintf('%d ', temp2(i));
    end

    fprintf('\n-----------------------------------\n');
