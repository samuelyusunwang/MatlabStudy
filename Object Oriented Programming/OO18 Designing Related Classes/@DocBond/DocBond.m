classdef DocBond < DocAsset
    %DOCBOND Summary of this class goes here
    %   OO Chapter 18
    
    properties
        FaceValue = 0;
        Yield = 0;
        CurrentBondYield = 0;
    end
    
    methods
        function obj = DocBond(description, fValue, yld, currentYield)
            % constructor
            if nargin ~= 4
                description = '';
                fValue = 0;
                yld = 0;
                currentYield = 0;
            end
            marketValue = DocBond.calcValue(fValue, yld, currentYield);
            obj = obj@DocAsset(description, 'bond', marketValue);
            obj.FaceValue = fValue;
            obj.Yield = yld;
            obj.CurrentBondYield = currentYield;
        end
        
        function disp(obj)
            % Display bond
            disp@DocAsset(obj)
            fprintf('Face value of bonds: $%g\nYield: %3.2f%%\n',...
                    obj.FaceValue, obj.Yield);
        end
        
    end %eom
    
    methods (Static)
        function marketValue = calcValue(faceValue, yield, currentYield)
            if currentYield <=0 || yield <= 0
                marketValue = faceValue;
            else
                marketValue = faceValue * yield / currentYield;
            end
        end 
        
    end %eomstatic
    
end %eoc

