classdef DocAsset
    %DOCASSET Summary of this class goes here
    %   OO Chapter 18
    
    properties
        Description = '';
        CurrentValue = 0; 
    end
    
    properties(SetAccess = private)
        Date % Set Vvlue in constructor
        Type = 'savings';   % default
    end
    
    methods
        function a = DocAsset(description, type, value)
            % DocAsset constructor
            if nargin > 0
                a.Description = description;
                a.Type = type;
                a.CurrentValue = value;
            end
        end
        
        function obj = set.Type(obj,type)
            if ~(strcmpi(type,'bond') || strcmpi(type,'stock') || strcmpi(type,'savings'))
                error('Type must be either bond, stock or savings')
            end
            obj.Type = type;
        end
        
        function disp(obj)
            % Display a DocAsset object
            fprintf('Description: %s\nType: %s\nCurrentValue:%9.2f\n',...
                    obj.Description, obj.Type, obj.CurrentValue);
        end
        
        
               
    end  %eom
    
end  %eoc

