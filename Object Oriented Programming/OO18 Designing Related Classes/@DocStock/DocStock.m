classdef DocStock < DocAsset
    %DOCSTOCK Summary of this class goes here
    %   OO Chapter 18
    
    properties
        NumShares = 0;
        SharePrice = 0;
    end
    
    methods
        function obj = DocStock(description, nShares, sPrice)
            % DocStock constructor
            if nargin ~= 3  % support no argument constructor syntax
                description = '';
                nShares = 0;
                sPrice = 0;
            end
            obj = obj@DocAsset(description, 'stock', sPrice*nShares);
            obj.NumShares = nShares;
            obj.SharePrice = sPrice;
        end
        
        function disp(obj)
            % Display method
            disp@DocAsset(obj)
            fprintf('Number of shares: %g\nShare price: %3.2f\n',...
                    obj.NumShares, obj.SharePrice);
        end
        
    end %eom
    
end %eoc

