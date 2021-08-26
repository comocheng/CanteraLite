classdef Transport_C < handle
    properties
        th
        tr_id
    end
    properties(Constant = true)
        lib = 'cantera_shared'
    end
    methods
        % Transport class constructor
        function tr = Transport_C(tp, model, loglevel)
            checklib;
            tr.tr_id = 0;
            if nargin == 2
                model = 'default'
            end
            
            if nargin < 3
                loglevel = 4;
            end
            
            if ~isa(tp, 'ThermoPhase_C')
                error(['The first argument must be an ', ...
                      'instance of class ThermoPhase']);
            else
                tr.th = tp;
                if strcmp(model, 'default')
                    tr.tr_id = calllib(tr.lib, 'trans_newDefault', ...
                                       tp.tp_id, loglevel);
                else
                    tr.tr_id = calllib(tr.lib, 'trans_new', ...
                                       model, tp.tp_id, loglevel);
                end
            end
        end
        
        % Delete the kernel object
        function tr_clear(tr)
            checklib;
            calllib(tr.lib, 'trans_del', tr.tr_id);
        end
    end
end