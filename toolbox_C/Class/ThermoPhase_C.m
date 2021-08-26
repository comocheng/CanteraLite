classdef ThermoPhase_C < handle
    properties
        tp_owner
        tp_id
        T
        P
        rho
        X
        Y
    end
    
    properties(Constant = true)
        lib = 'cantera_shared'
    end
    
    methods
        % Thermo phase class constructor
        function tp = ThermoPhase_C(src, id)
            checklib;
            if nargin > 2
                error('ThermoPhase expects 1 or 2 input arguments.');
            end
            if nargin == 1
                id = '-';
            end
            tp.tp_owner = 1;
            tp.tp_id = calllib(tp.lib, 'thermo_newFromFile', src, id);
        end
        
        % Delete the kernel object.
        function tp_clear(tp)
            checklib;
            calllib(tp.lib, 'thermo_del', tp.tp_id);
        end
        
        % Get thermal properties
        function temperature = get.T(tp)
            checklib;
            temperature = calllib(tp.lib, 'thermo_temperature', tp.tp_id);
        end
        
        function pressure = get.P(tp)
            checklib;
            pressure = calllib(tp.lib, 'thermo_pressure', tp.tp_id);   
        end
        
        function density = get.rho(tp)
            checklib;
            density = calllib(tp.lib, 'thermo_density', tp.tp_id);
        end
        
        function n = molarDensity(tp)
            checklib;
            n = calllib(tp.lib, 'thermo_molarDensity', tp.tp_id);
        end
        
        function n = meanMolecularWeight(tp)
            checklib;
            n = calllib(tp.lib, 'thermo_meanMolecularWeight', tp.tp_id);
        end
        
        function nsp = nSpecies(tp)
            checklib;
            nsp = calllib(tp.lib, 'thermo_nSpecies', tp.tp_id);
        end
        
        function nel = nElements(tp)
            checklib;
            nel = calllib(tp.lib, 'thermo_nElements', tp.tp_id);
        end
        
        function amu = atomicMasses(tp)
            checklib;
            nel = tp.nElements;
            aa = zeros(1, nel);
            pt = libpointer('doublePtr', aa);
            calllib(tp.lib, 'thermo_getAtomicWeights', ...
                    tp.tp_id, nel, pt);
            amu = pt.Value;
        end
        
        function moleFractions = get.X(tp)
            checklib;
            nsp = tp.nSpecies;
            xx = zeros(1, nsp);
            pt = libpointer('doublePtr', xx);
            calllib(tp.lib, 'thermo_getMoleFractions', ...
                    tp.tp_id, nsp, pt);
            moleFractions = pt.Value;
        end
        
        function massFractions = get.Y(tp)
            checklib;
            nsp = tp.nSpecies;
            yy = zeros(1, nsp);
            pt = libpointer('doublePtr', yy);
            calllib(tp.lib, 'thermo_getMassFractions', ...
                    tp.tp_id, nsp, pt);
            massFractions = pt.Value; 
        end
        
        % Set thermal properties
        function tp = set.T(tp, temperature)
            checklib;
            if temperature <= 0
                error('The temperature must be positive');
            end
            calllib(tp.lib, 'thermo_setTemperature', tp.tp_id, temperature);
        end
        
        function tp = set.P(tp, pressure)
            checklib;
            if pressure <= 0
                error('The pressure must be positive');
            end
            calllib(tp.lib, 'thermo_setPressure', tp.tp_id, pressure);
        end
        
        function tp = set.rho(tp, density)
            checklib;
            if density <= 0
                error('The density must be positive');
            end
            calllib(tp.lib, 'thermo_setDensity', tp.tp_id, density);    
        end
        
        % Equilibrate
        function tp = equilibrate(tp, xy, solver, rtol, maxsteps, ...
                                  maxiter, loglevel)
            checklib;
            % use the ChemEquil solver by default
            if nargin < 3
                solver = -1;
            end
            if nargin < 4
                rtol = 1.0e-9;
            end
            if nargin < 5
                maxsteps = 1000;
            end
            if nargin < 6
                maxiter = 100;
            end
            if nargin < 7
                loglevel = 0;
            end
            calllib(tp.lib, 'thermo_equilibrate', tp.tp_id, xy, solver, ...
                    rtol, maxsteps, maxiter, loglevel);
        end
        
        % Display thermo properties
        function display(tp, threshold)
            if nargin < 2 || ~isnumeric(threshold)
                threshold = 1e-14;
            end
            calllib(tp.lib, 'thermo_print', tp.tp_id, 1, threshold);
        end
        
    end
end