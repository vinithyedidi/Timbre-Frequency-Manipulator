function harmonics = generateHarmonics(fund, num, timbre, fs, dur)
% Given an input fundamental frequency and number of overtones, it adds
% the overtones (freq of nth overtone = fund * n) to generate a saw wave.
% Additionally, if you input the value [0, 1] for each overtone in a 
% timbre vector, it emphasizes or dampens the overtone corresponding to 
% the value.

default = zeros(num,1);         % default timbre is that each harmonic is
for n = 1:num                   % 1/n the volume of the fundamental -> this
    default(n,1) = (1/n)^(n-1); % is a timbre of brighter quality.
end
if timbre == 0
    timbre = default;

harmonics = zeros((fs*dur), num);
for n = 1:num                 % generates the harmonics matrix, nth column
    wave = generateSine((fund*n), fs, dur); % is the sine wave of the
    harmonics(:, n) = timbre(n) * wave;     % (n-1)th harmonic.
end   
end