classdef Solution_New < handle
    properties
        thermo
        kinetics
        transport
    end
    methods 
        function s = Solution_New(src, id, trans)
            if nargin == 1
                id = '-';
            end
            t = ThermoPhase_New(src, id);
            k = Kinetics(t, src, id);
            s.kinetics = k;
            s.thermo = t;
            if nargin == 3
                if (strcmp(trans, 'default') || strcmp(trans, 'None')...
                    || strcmp(trans, 'Mix') || strcmp(trans, 'Multi'))
                    tr = Transport(t, trans, 0);
                else
                    error('Unknown transport modelling specified.')
                end
            else
                tr = Transport(t, 'default', 0);
            end
            s.transport = tr;
        end
    end
end