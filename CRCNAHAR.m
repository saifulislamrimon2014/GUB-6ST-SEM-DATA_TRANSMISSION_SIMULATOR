data = input('Enter data to be transmitted: ', 's');
gen_poly = input('Enter the Generating polynomial: ', 's');

N = length(gen_poly);
data_length = length(data);

% Pad the data with n-1 zeros
data = [data repmat('0', 1, N-1)];

disp('----------------------------------------');
fprintf('Data padded with n-1 zeros : %s\n', data);
disp('----------------------------------------');

% CRC calculation
check_value = data(1:N);

i = N + 1;
while i <= data_length + N - 1
    if check_value(1) == '1'
        % XOR function
        for j = 1:N
            check_value(j) = char(xor(str2num(check_value(j)), str2num(gen_poly(j))) + '0');
        end

        check_value(1:N-1) = check_value(2:end);
        check_value(N) = data(i);
        i = i + 1;
    else
        check_value(1:N-1) = check_value(2:end);
        check_value(N) = data(i);
        i = i + 1;
    end
end

fprintf('CRC or Check value is : %s\n', check_value);

% Append CRC to the data
data(data_length+1:data_length+N-1) = check_value(2:end);

disp('----------------------------------------');
fprintf('Final data to be sent : %s\n', data);
disp('----------------------------------------');

% Receiver
received_data = input('Enter the received data: ', 's');
disp('-----------------------------');
fprintf('Data received: %s\n', received_data);

% CRC calculation for received data
check_value = received_data(1:N);

i = N + 1;
while i <= data_length + N - 1
    if check_value(1) == '1'
        % XOR function
        for j = 1:N
            check_value(j) = char(xor(str2num(check_value(j)), str2num(gen_poly(j))) + '0');
        end

        check_value(1:N-1) = check_value(2:end);
        check_value(N) = received_data(i);
        i = i + 1;
    else
        check_value(1:N-1) = check_value(2:end);
        check_value(N) = received_data(i);
        i = i + 1;
    end
end

% Error detection
if any(check_value == '1')
    disp('Error detected');
else
    disp('No error detected');
end