ArraySize = input('Enter the size of Main Message Array: ');
promptMsg = 'Enter the bits of your message (use space between each bit): ';
MainMsg = input(promptMsg);
if length(MainMsg) ~= ArraySize
    error('Invalid input size. Please enter the correct number of bits.');
end
bitStuffing(ArraySize, MainMsg);

function ReciMsg = bitStuffing(ArraySize, MainMsg)
    ReciMsg = zeros(1, 1000);
    i = 1;
    j = 1;
    StuffedCount = 0;
    Count = 0;

    for k = 1:length(MainMsg)
        if MainMsg(k) == 1
            ReciMsg(j) = MainMsg(k);
            Count = Count + 1;

            if Count == 5 && k < length(MainMsg)
                j = j + 1;
                ReciMsg(j) = 0;
                StuffedCount = StuffedCount + 1;
            end
            i = k;
        else
            ReciMsg(j) = MainMsg(k);
            Count = 0;
        end
        j = j + 1;
    end

    disp('Stuffed Message: ');
    disp(ReciMsg(1:j - 1));

    prompt = 'Do you want to deStuff the Stuffed Message?\nPress: 1 (YES)\nPress: 0 (NO) ';
    key = input(prompt);
    if key == 1
        bitDestuffing(ArraySize, ReciMsg);
    else
        disp('Thank you for using!');
        return;
    end
end

function bitDestuffing(ArraySize, ReciMsg)
    % Initialize variables
    MainMsg = zeros(1, ArraySize);
    i = 1;
    j = 1;
    consecutiveOnes = 0;

    % Loop through received message
    while i <= ArraySize
        % Check current bit
        if ReciMsg(i) == 1
            % Track consecutive 1s and copy them to de-stuffed message
            consecutiveOnes = consecutiveOnes + 1;
            MainMsg(j) = ReciMsg(i);
            j = j + 1;
        else
            % Handle non-1 bits
            if consecutiveOnes < 5
                % Copy non-1s or non-stuffed 0s directly
                MainMsg(j) = ReciMsg(i);
                j = j + 1;
            else
                % Skip stuffed 0 if preceded by 5 consecutive 1s
                consecutiveOnes = 0;
                % Additional check to avoid skipping the last bit if it's non-zero
                if i < ArraySize
                    MainMsg(j) = ReciMsg(i);
                    j = j + 1;
                end
            end
        end
        i = i + 1;
    end

    % Display de-stuffed message
    disp(['De-Stuffed Message: ' num2str(MainMsg(1:j - 1))]);
    disp('Thank you for using!');
end
