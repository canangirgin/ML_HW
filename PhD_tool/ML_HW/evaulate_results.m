function output = evaulate_results(outClass,groups)
cp = classperf(groups,outClass);
output = cp.CorrectRate;
end