function crc_matlab()
    % Define the data and polynomial
    data = input('Enter data to be transmitted: ', 's');
    gen_poly = input('Enter the Generating polynomial: ', 's');
    
    data_length = length(data);
    N = length(gen_poly);
    
    % Append zeros to the data
    appended_data = [data, repmat('0', 1, N-1)];
    
    % Perform CRC
    remainder = crc_division(appended_data, gen_poly);
    
    % Generate codeword
    codeword = [data, remainder];
    
    fprintf('\nFinal codeword to be sent: %s\n', codeword);
    
    % Simulate receiver
    received_data = input('\nEnter the received codeword: ', 's');
    received_remainder = crc_division(received_data, gen_poly);
    
    if any(received_remainder ~= '0')
        fprintf('\nError detected.\n');
    else
        fprintf('\nNo error detected.\n');
    end
end

function remainder = crc_division(input_data, gen_poly)
    N = length(gen_poly);
    temp_data = input_data(1:N);
    
    for i = 1:length(input_data) - N + 1
        if temp_data(1) == '1'
            temp_data = xor_strings(temp_data, gen_poly);
        end
        
        if i+N <= length(input_data)
            temp_data = [temp_data(2:end), input_data(i+N)];
        else
            temp_data = temp_data(2:end);
        end
    end
    
    remainder = temp_data;
end

function result = xor_strings(a, b)
    result = char(xor(a-'0', b-'0') + '0');
end
