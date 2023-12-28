function  saw = generateSaw(harmonics)
% Uses the harmonics matrix from generateHarmonics() to add each harmonic
% onto the fundamental wave, creating a saw wave with the same fundamental
% frequency. Stores this data into saw, a vector.

%harmonics = generateHarmonics(fund, num, timbre, fs, dur);

dims = size(harmonics);
len = dims(1);
num_harmonics = dims(2);

saw = zeros(len, 1);
for n = 1:num_harmonics
    saw = saw + harmonics(:, n);
end

saw = saw/max(saw);