
coeffs = singlepolecascade([1/4 1/3 1/2]);

function coeffs = singlepolecascade(params)

N = length(params);

if length(unique(params))~=N
    error('Transfer function has repeated poles.');
end

% Initialize NxN matrix for linear system

A = zeros(N);

% Fill in each column of A, based on corresponding product of terms

for i=1:N
    % each time take out one coefficient
    temp_params = params;
    temp_params(i) = [];
    A(:,i) = poly(temp_params);
end

% Determine right-hand side

rhs = [1;zeros(length(A)-1,1)];

% Solve linear system to get coefficients

coeffs = A\rhs;
end