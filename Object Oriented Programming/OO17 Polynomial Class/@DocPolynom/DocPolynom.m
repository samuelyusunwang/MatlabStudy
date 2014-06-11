classdef DocPolynom
    % a class of polynomial
    
    properties
        coef
    end
    
    methods
        function obj = DocPolynom(c)    
            % constructor & a copy constructor
            if isa(c,'DocPolynom')
                obj.coef = c.coef;
            else
                obj.coef = c(:).';
            end
        end
        
        function obj = set.coef(obj, val)
            % coef set method
            if ~isa(val,'double')
                error('Coefficients must be of class double');
            end
            ind = find(val(:).' ~= 0);
            if ~isempty(ind)
                obj.coef = val(ind(1):end);
            else
                obj.coef = val;
            end
        end
        
        function c = double(obj)
            % DocPolynom/Double Converter
            c = obj.coef;
        end
        
        function str = char(obj)
            % Created a formatted display of the polynom as powers of x
            if all(obj.coef == 0)
                s = '0';
                str = s;
                return;
            else
                N = length(obj.coef);
                s = cell(1,N);
                
                sign = cell(1,N);
                sign(obj.coef>=0) = {'+'};
                sign(obj.coef<0) = {'-'};
                if obj.coef(1)>0
                    sign(1) = {''};
                end               
                
                for i = 1:N-2
                    s{i} = [sign{i},' ', num2str(abs(obj.coef(i))), '*x^', num2str(N-i), ' '];
                end
                if N > 1
                    s{N-1} = [sign{N-1},' ', num2str(abs(obj.coef(N-1))), '*x '];
                end
                s{N} = [sign{N},' ', num2str(abs(obj.coef(N)))];
                
                s(obj.coef==0) = '';
                
                if obj.coef(1) == 1
                    s{1} = ['x^', num2str(N-1),' '];
                end

            end
            str = [s{:}];
        end
        
        function disp(obj)
            % DISP Display object in Matlab syntax
            c = char(obj);
            if iscell(c)
                disp(['   ', c{:}])
            else
                disp(c)
            end
        end
        
        function b = subsref(obj, s)
            switch s(1).type
                case '()'
                    ind = s.subs{:};
                    b = polyval(obj.coef, ind);
                case '.'
                    switch s(1).subs
                        case 'coef'
                            b = obj.coef;
                        case 'disp'
                            disp(obj)
                        otherwise
                            if length(s)>1
                                b = obj.(s(1).subs)(s(2).subs{:});
                            else
                                b = obj.(s.subs);
                            end
                    end
                otherwise
                    error('Specify value for x as obj(x)')
            end
        end
        
        function r = plus(obj1,obj2)
            % Plus Implement obj1 + obj2 for DocPolynom
            obj1 = DocPolynom(obj1);
            obj2 = DocPolynom(obj2);
            k = length(obj2.coef) - length(obj1.coef);
            r = DocPolynom([zeros(1,k) obj1.coef] + [zeros(1,-k) obj2.coef]);
        end
        
        function r = minus(obj1,obj2)
            % Minus Implement obj1 - obj2 for DocPolynom
            obj1 = DocPolynom(obj1);
            obj2 = DocPolynom(obj2);
            k = length(obj2.coef) - length(obj1.coef);
            r = DocPolynom([zeros(1,k) obj1.coef] - [zeros(1,-k) obj2.coef]);
        end
        
        function r = mtimes(obj1,obj2)
            % Mtimes Implemnt obj1 * obj2 for DocPolynoms
            obj1 = DocPolynom(obj1);
            obj2 = DocPolynom(obj2);
            r = DocPolynom(conv(obj1.coef,obj2.coef));
        end
        
    end %eom
    
end %eoc











