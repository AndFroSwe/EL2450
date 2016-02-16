time1 = []

% Create a time axis like [1 2 2 3 4 4 5 6 6.... ] for schedule plot
for i = 1:10
    if (mod(i, 2) == 0) % If even
        time1 = [time1 i i]
    else
        time1 = [time1 i]
    end
end


        