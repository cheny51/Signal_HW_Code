% Create a signal that's a series of increasing frequency cosines
y1=[]; 
t = [];
tb = 0:.0001:0.9999;
for i=1:5; 
    t = [t, tb+(i-1)];
   y1 = [y1, cos(2*pi*(i*100+400)*tb)]; 
end
[df,T] = dominantfreq(y1,t);
dftrue = kron([500 600 700 800 900], ones(1,10));
Ttrue = 0.05:.1:4.95;
assert(norm(df-dftrue)<1e-10,'Dominant frequencies are incorrect.');
assert(norm(T-Ttrue)<1e-10,'Time bins are incorrect.');

function [domf,T] = dominantfreq(y,t)

% Compute sampling frequency in Hz from t vector
fs = 1/(t(2)-t(1));

% Determine 100-ms-wide Hamming window
win = hamming(0.1*fs);

% Compute the spectrogram (non-overlapping windows, 10Hz-wide bins)
[S,F,T] = spectrogram(y, win, 0, 0:10:fs/2, fs);
figure()
% NOTE: This is the same as calling spectrogram with no outputs.
surf(T,F,10*log10(abs(S)),'EdgeColor','none');   
axis xy; axis tight; colormap(jet); view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');
colorbar
% Find the locations in each time bin where the spectrogram has largest magnitude

% S: A matrix, recording the strength of the frequency as f and t varies,
% the goal is to find out the maximum strength, so find out |S| is helpful!

% Convert all complex number in S to magnitude
mag_S = [];
for K = 1:length(T)
    % K: horizontal coordinate column-coordinate on S
    % L: vertical coordinate   row-coordinate   on S
    % (K,L) represent specific entry in the matrixS
    for L = 1:length(F)
        % this loop is finding the magnitude of the frequency strength at
        % different row per column k
        mag_S(L,K) = abs(S(L,K));
    end
end

% Now, iterate through each column and find out the maximum magnitude of S
% so to locate down the location of f where it is the highest magnitude as
% t varies.

for K = 1:length(T)
    % pull out the highest S at each t
    max_mag_value = max(mag_S, [], 1);
    % reflect the coordinate/index of (row, column) for each max_mag_value is
    % situated. Row -> frequency -> w, Column -> time -> y

    
    [max_S_index_w max_S_index_t] = find(mag_S == max_mag_value(K));
    size_max_S_index = size(max_S_index_w);
    if size_max_S_index(1) > 1 
        % if there's more than 1 dominant frequency in the same t-column, then
        % select the first row value is good enough
        max_S_index_w = max_S_index_w(1);
        domf(K) = F(max_S_index_w);
    else
        domf(K) = F(max_S_index_w);
    end
end
% Determine frequencies corresponding to these indices


end