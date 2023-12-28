function sine = generateSine(freq, fs, dur)

  % Given input freq, sample rate, and duration, it outputs an array 
  % containing data for a sine wave at that frequency.
t = (0 : (1/fs) : dur)'; %time in seconds, in increments of 1/fs
t(end) = [];
sine = sin(2*pi*freq*t);
end

