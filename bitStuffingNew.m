% Example usage
inputFrame = [1, 1, 1, 1, 1, 1];
disp('Input:');
disp(inputFrame);

% Perform bit stuffing
stuffedFrame = bitStuffing(inputFrame);
disp('Output:');
disp(stuffedFrame);

% Perform bit destuffing
disp('De-stuffing:');
destuffedFrame = bitDestuffing(stuffedFrame);
disp('Output:');
disp(destuffedFrame);



function stuffedFrame = bitStuffing(frame)
    % Perform bit stuffing
    stuffedFrame = [];
    count = 0;

    for bit = frame
        if bit == 1
            count = count + 1;
        else
            count = 0;
        end

        stuffedFrame = [stuffedFrame, bit];

        % Check for five consecutive ones and stuff a 0 bit
        if count == 5
            stuffedFrame = [stuffedFrame, 0];
            count = 0;
        end
    end
end

function destuffedFrame = bitDestuffing(frame)
    % Perform bit destuffing
    i = 1;
    count = 0;
    while i <= length(frame)
        if frame(i) == 1
            count = count + 1;
        else
            count = 0;
        end
        if count == 4 && (frame(i) == 0 || i == length(frame))
            continue;
        end
        count = 0;
        i = i + 1;
    end
    destuffedFrame = frame;
end
