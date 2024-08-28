function mre = mean_relative_error(actual, estimate)
	mre = mean(abs((actual - estimate) ./ actual));
end
