function tests = showTests()

tests = struct('functionHandle',[],'name',{},'expectedValue',{});

test = struct('functionHandle',@testShowConstants001,...
              'name','Show Model Constants',...
              'expectedValue',true);
tests(end+1)=test;

test = struct('functionHandle',@testShowCV001,...
              'name','Show Model Computed Variables',...
              'expectedValue',true);
tests(end+1)=test;

test = struct('functionHandle',@testShowSV001,...
              'name','Show Model State Variables',...
              'expectedValue',true);
tests(end+1)=test;
