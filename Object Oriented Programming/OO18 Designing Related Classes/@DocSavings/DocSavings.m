classdef DocSavings < DocAsset
    %DOCSAVINGS Summary of this class goes here
    %   OO Chapter 18
    
    properties
        InterestRate = 0;
    end
    
    methods
        function obj = DocSavings(description, balance, interestRate)
            % Constructor
            if nargin ~= 3
                description = '';
                balance = 0;
                interestRate = 0;
            end
            obj = obj@DocAsset(description,'savings',balance);
            obj.InterestRate = interestRate;
        end 
        
        function disp(obj)
            % Display function
            disp@DocAsset(obj)
            fprintf('%s%3.2f%%\n','Interest Rate: ',obj.InterestRate);
        end
            
    end  %eom
    
end  %eoc

