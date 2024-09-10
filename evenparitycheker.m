data = input("This is a program for even parity checking.\nEnter the data: ", "s");

count = 0;

for i = 1:N
    if data(i) == '1'
        count = count + 1;
    end
end

new_length = N + 1;
new_data = blanks(new_length);

if mod(count, 2) == 0
    new_data(1) = '1';
else
    new_data(1) = '0';
end

for i = 2:new_length
    new_data(i) = data(i - 1);
end
    fprintf("After adding '0' at the front of the data:\n%s\n", new_data);
