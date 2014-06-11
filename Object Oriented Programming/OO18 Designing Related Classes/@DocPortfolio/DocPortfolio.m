classdef DocPortfolio
    %DOCPORTFOLIO Summary of this class goes here
    %   OO Chapter 18
    
    properties
        Name = '';   % Name of client
    end
    
    properties (SetAccess = private)
        IndAssets = {};
        TotalValue = 0;
    end
    
    methods 
        function obj = DocPortfolio(name, varargin)
            % constructor
            if nargin > 0
                obj.Name = name;
                for k = 1:length(varargin)
                    obj.IndAssets{k} = varargin(k);
                    asset_value = obj.IndAssets{k}{1}.CurrentValue;
                    obj.TotalValue = obj.TotalValue + asset_value;
                end
            end
        end
        
        function disp(obj)
            % display
            fprintf('\nAssets for Client: %s\n', obj.Name);
            for k = 1:length(obj.IndAssets)
                fprintf('\n');
                disp(obj.IndAssets{k}{1});    %Dispatch to corresponding disp           
            end
            fprintf('\nTotal Value: $%0.2f\n',obj.TotalValue);
        end
        
        function pie3(obj)
            % overload Matlab pie3()
            % Step 1: Get the current value of each asset
            stock_amt = 0; bond_amt = 0; savings_amt = 0;
            for k = 1:length(obj.IndAssets)
                if isa(obj.IndAssets{k}{1},'DocStock')
                    stock_amt = stock_amt + obj.IndAssets{k}{1}.CurrentValue;
                elseif isa(obj.IndAssets{k}{1},'DocBond')
                    bond_amt = bond_amt +obj.IndAssets{k}{1}.CurrentValue;
                elseif isa(obj.IndAssets{k}{1},'DocSavings')
                    savings_amt = savings_amt + obj.IndAssets{k}{1}.CurrentValue;
                end
            end
            
            % Step 2: Create labels and data for the pie graph
            k = 1;
            if stock_amt ~= 0
                label(k) = {'Stocks'};
                pie_vector(k) = stock_amt;
                k = k+1;
            end
            if bond_amt ~= 0
                label(k) = {'Bonds'};
                pie_vector(k) = bond_amt;
                k = k+1;
            end
            if savings_amt ~= 0 
                label(k) = {'Savings'};
                pie_vector(k) = savings_amt;
            end
            
            % Step 3: Call pie3(), adjust fonts and colors
            pie3(pie_vector,label); 
            set(gcf,'Renderer','zbuffer');
            set(findobj(gca,'Type','Text'),'FontSize',14,'FontWeight','bold')
            colormap prism
            stg(1) = {['Portfolio Composition for ',obj.Name]};
            stg(2) = {['Total Value of Assets: $', num2str(obj.TotalValue,'%0.2f')]};
            title(stg,'FontSize',10);
        end
        
    end %eom
    
    
end %eoc

