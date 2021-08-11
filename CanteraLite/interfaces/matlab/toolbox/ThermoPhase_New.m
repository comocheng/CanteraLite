classdef ThermoPhase_New < handle
    properties
        owner
        tp_id
    end
    methods (Access = private)
        % Call MEX interface
        function i = thermo_ops(tp, class, job, n, a, b)
            if nargin == 4
                i = ctmethods_dummy(class, job, n);
            elseif nargin == 5
                i = ctmethods_dummy(class, job, n, a);
            else
                i = ctmethods_dummy(class, job, n, a, b);
            end
        end
    end
    methods
        % Thermo phase class constructor
        function t = ThermoPhase_New(src, id)
            if nargin > 2
                error('ThermoPhase expects 1 or 2 input arguments.');
            end
            if nargin == 1
                id = '-';
            end
            t.owner = 1;
            [class_id, job_id] = FunctionDictionary('thermo_newFromFile');
            t.tp_id = t.thermo_ops(class_id, job_id, 0, src, id);
        end
        
        % Get thermal properties
        function t = temperature(tp)
            [class_id, job_id] = FunctionDictionary('thermo_temperature');
            t = tp.thermo_ops(class_id, job_id, tp.tp_id);
        end
        function rho = density(tp)
            [class_id, job_id] = FunctionDictionary('thermo_density');
            rho = tp.thermo_ops(class_id, job_id, tp.tp_id);
        end
        function n = molarDensity(tp)
            [class_id, job_id] = FunctionDictionary('thermo_molarDensity');
            n = tp.thermo_ops(class_id, job_id, tp.tp_id);
        end
        
        % Set thermal properties
        function setTemperature(tp, t)
            if t <= 0
                error('The temperature must be positive');
            end
            [class_id, job_id] = FunctionDictionary('thermo_setTemperature');
            tp.thermo_ops(class_id, job_id, tp.tp_id);
        end
        function setDensity(tp, rho)
            if rho <= 0
                error('The density must be positive');
            end
            [class_id, job_id] = FunctionDictionary('thermo_setDensity');
            tp.thermo_ops(class_id, job_id, tp.tp_id);    
        end
        
    end
end