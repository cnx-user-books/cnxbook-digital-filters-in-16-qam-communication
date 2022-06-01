


function corrupted = channela(original, amp_error)
%This function will mess with the values of each element in original.
%Note: an amp_error of one is actually a lot in my opinion
%   original - the vector of the original signal
%   amp_error - a scalar for which the amount of noise that will be added or subtracted

corrupted = original+(amp_error*(rand(1,length(original))-.5));

end