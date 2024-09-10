

% Example usage
userIPv4 = input('Enter an IP address (Like: 192.168.1.1): ', 's');

% Convert IPv4 to binary
binaryIP = ipv4ToBinary(userIPv4);

disp(['IP address in binary: ' regexprep(binaryIP, '(\d{8})', '$1 ')]);
convertBack = input('Do you want to convert back to decimal? (1/0): ');

if convertBack == 1
    % Convert binary back to IPv4
    restoredIPv4 = binaryToIPv4(binaryIP);
    disp(['Decimal IP address: ' restoredIPv4]);
else
    disp('Thank you for using!');
end


% Function to convert IPv4 to binary
function binaryIP = ipv4ToBinary(ipv4Address)
    % Split the IPv4 address into octets
    octets = str2double(strsplit(ipv4Address, '.'));

    % Convert each octet to binary
    binaryIP = dec2bin(octets, 8);

    % Combine binary octets into a single binary string
    binaryIP = reshape(binaryIP', 1, []);
end

% Function to convert binary to IPv4
function ipv4Address = binaryToIPv4(binaryIP)
    % Convert binary string to numeric array
    binaryArray = reshape(binaryIP, 8, []).';

    % Convert each octet to decimal
    decimalOctets = bin2dec(binaryArray);

    % Join decimal octets into an IPv4 address
    ipv4Address = join(string(decimalOctets), '.');
end