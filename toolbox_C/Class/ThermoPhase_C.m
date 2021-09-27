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
        %% ThermoPhase class constructor
        
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
        
        %% Utility methods
        
        function display(tp, threshold)
            % Display thermo properties
            
            if nargin < 2 || ~isnumeric(threshold)
                threshold = 1e-14;
            end
            calllib(tp.lib, 'thermo_print', tp.tp_id, 1, threshold);
        end
                
        function tp_clear(tp)
            % Delete the kernel object.
            
            checklib;
            calllib(tp.lib, 'thermo_del', tp.tp_id);
        end
        
        %% PhaseGet methods
        
        function temperature = get.T(tp)
            % Get the temperature.
            %
            % :return:
            %    Double temperature. Unit: K
            
            checklib;
            temperature = calllib(tp.lib, 'thermo_temperature', tp.tp_id);
        end
        
        function pressure = get.P(tp)
            % Get the pressure.
            %
            % :return:
            %    Double pressure. Unit: Pa
            
            checklib;
            pressure = calllib(tp.lib, 'thermo_pressure', tp.tp_id);   
        end
        
        function density = get.rho(tp)
            % Get the density.
            %
            % :return:
            %    Double mass density. Unit: kg/m^3
            
            checklib;
            density = calllib(tp.lib, 'thermo_density', tp.tp_id);
        end
        
        function n = molarDensity(tp)
            % Get the molar density.
            %
            % :return:
            %    Double molar density. Unit: kmol/m^3
            
            checklib;
            n = calllib(tp.lib, 'thermo_molarDensity', tp.tp_id);
        end
        
        function mmw = meanMolecularWeight(tp)
            % Get the mean molecular weight.
            %
            % :return:
            %    Double mean molecular weight. Unit: kg/kmol
            
            checklib;
            mmw = calllib(tp.lib, 'thermo_meanMolecularWeight', tp.tp_id);
        end
        
        function nel = nElements(tp)
            % Get the number of elements.
            %
            % :return:
            %    Integer number of elements in the phase.
            
            checklib;
            nel = calllib(tp.lib, 'thermo_nElements', tp.tp_id);
        end
        
        function nsp = nSpecies(tp)
            % Get the number of species.
            %
            % :return:
            %    Integer number of species in the phase.
            
            checklib;
            nsp = calllib(tp.lib, 'thermo_nSpecies', tp.tp_id);
        end
        
        function k = speciesIndex(tp, name)
            % Get the index of a species given the name. 
            % The index is an integer assigned to each species in sequence
            % as it is read in from the input file. 
            %
            % Note: In keeping with the conventions used by Matlab, the
            % indices start from 1 instead of 0 as in Cantera C++ and
            % Python interfaces. 
            %
            % :param name:
            %    String or cell array of species whose index is requested.
            % :return:
            %    Integer number of species in the phase.
            
            checklib;
            if iscell(name)
                [m, n] = size(name);
                k = zeros(m, n);
                for i = 1:m
                    for j = 1:n
                        k(i, j) = calllib(tp.lib, 'thermo_speciesIndex', ...
                                          tp.tp_id, name{i, j}) + 1;
                        if k(i, j) > 1e3
                            warning(['Species ', name{i, j}, ...
                                   ' does not exist in the phase']);
                            k(i, j) = -1;
                        end
                    end
                end
            elseif ischar(name)
                k = calllib(tp.lib, 'thermo_speciesIndex', ...
                            tp.tp_id, name) + 1;
                if k > 1e3
                    warning(['Species ', name, ...
                           ' does not exist in the phase.']);
                    k = -1;
                end
            else
                error('Name must be either a string or cell array of strings.')
            end
        end
                
        function k = elementIndex(tp, name)
            % Get the index of an element given the name. 
            % The index is an integer assigned to each element in sequence
            % as it is read in from the input file. 
            %
            % Note: In keeping with the conventions used by Matlab, the
            % indices start from 1 instead of 0 as in Cantera C++ and
            % Python interfaces. 
            %
            % :param name:
            %    String or cell array of elements whose index is requested
            % :return:
            %    Integer number of elements in the phase.
            
            checklib;
            if iscell(name)
                [m, n] = size(name);
                k = zeros(m, n);
                for i = 1:m
                    for j = 1:n
                        k(i, j) = calllib(tp.lib, 'thermo_elementIndex', ...
                                          tp.tp_id, name{i, j}) + 1;
                        if k(i, j) > 1e3
                            warning(['Element ', name{i, j}, ...
                                   ' does not exist in the phase']);
                            k(i, j) = -1;
                        end
                    end
                end
            elseif ischar(name)
                k = calllib(tp.lib, 'thermo_elementIndex', ...
                            tp.tp_id, name) + 1;
                if k > 1e3
                    warning(['Element ', name, ...
                           ' does not exist in the phase']);
                    k = -1;
                end
            else
                error('name must be either a string or cell array of strings')
            end
        end
        
        
        function n = nAtoms(tp, species, element)
            % Get the number of atoms of an element in a species.
            %
            % :param k: 
            %    String species name or integer species number.
            % :param m:
            %    String element name or integer element number.
            % :return: 
            %    Integer number of atoms of the element in the species.
            if nargin == 3
                if ischar(species)
                    k = tp.speciesIndex(species);
                else k = species;
                end
                if k < 0
                    n = -1;
                    return
                end
                if ischar(element)
                    m = tp.elementIndex(element);
                else m = element;
                end
                if m < 0
                    n = -1;
                    return
                end
                n = calllib(tp.lib, 'thermo_nAtoms', tp.tp_id, k-1, m-1);
            else
                error('Two input arguments required.')
            end
        end
        
        function moleFractions = get.X(tp)
            % Get the mole fractions of all species.
            %
            % :return: 
            %    Vector of species mole fractions. 
            
            checklib;
            nsp = tp.nSpecies;
            xx = zeros(1, nsp);
            pt = libpointer('doublePtr', xx);
            calllib(tp.lib, 'thermo_getMoleFractions', ...
                    tp.tp_id, nsp, pt);
            moleFractions = pt.Value;
            
            % if no output argument is specified, a bar plot is produced.
            if nargout == 0
                figure
                set(gcf, 'Name', 'Mole Fractions')
                bar(moleFractions)
                xlabel('Species Number')
                ylabel('Mole Fraction')
                title('Species Mole Fractions')
            end
        end
        
        function x = moleFraction(tp, species)
            % Get the mole fraction of one or a list of species.
            %
            % :param species: 
            %    String or cell array of species whose mole fraction is
            %    requested.
            % :return: 
            %    Scalar or vector of species mole fractions.
            
            xarray = tp.X;
            if isa(species, 'char')
                k = tp.speciesIndex(tp, species);
                if  k > 0
                    x = xarray(k);
                else error("species not found.");
                end
            elseif isa(species, 'cell')
                n = length(species);
                x = zeros(1, n);
                for j = 1:n
                    k = tp.speciesIndex(tp, species{j});
                    if k > 0
                        x(j) = xarray(k);
                    else error("species not found.");
                    end
                end
            end
        end
        
        function massFractions = get.Y(tp)
            % Get the mass fractions of all species.
            %
            % :return: 
            %   Vector of species mass fractions. 
            
            checklib;
            nsp = tp.nSpecies;
            yy = zeros(1, nsp);
            pt = libpointer('doublePtr', yy);
            calllib(tp.lib, 'thermo_getMassFractions', ...
                    tp.tp_id, nsp, pt);
            massFractions = pt.Value;
            
            % If no output argument is specified, a bar plot is produced.
            if nargout == 0
                figure
                set(gcf, 'Name', 'Mole Fractions')
                bar(massFractions)
                xlabel('Species Number')
                ylabel('Mole Fraction')
                title('Species Mole Fractions')
            end
        end
        
        function y = massFraction(tp, species)
            % Get the mass fraction of one or a list of species.
            %
            % :param species: 
            %    String or cell array of species whose mass fraction is
            %    requested.
            % :return: 
            %    Scalar or vector of species mass fractions.
            
            yarray = tp.Y;
            if isa(species, 'char')
                k = tp.speciesIndex(tp, species);
                if  k > 0
                    y = yarray(k);
                else error("Error: species not found.")
                end
            elseif isa(species, 'cell')
                n = length(species);
                y = zeros(1, n);
                for j = 1:n
                    k = tp.speciesIndex(tp, species{j});
                    if k > 0
                        y(j) = yarray(k);
                    else error("Error: species not found.")
                    end
                end
            end
        end
        
        function mw = MolecularWeights(tp)
            % Get the array of molecular weights of all species.
            %
            % :return: 
            %   Vector of species molecular weights. Unit: kg/kmol
            
            checklib;
            nsp = tp.nSpecies;
            yy = zeros(1, nsp);
            pt = libpointer('doublePtr', yy);
            calllib(tp.lib, 'thermo_getMolecularWeights', ...
                    tp.tp_id, nsp, pt);
            mw = pt.Value;
        end
     
        function e = charges(tp)
            % Get the array of species charges.
            %
            % :return: 
            %    Vector of species charges. Unit: elem. charge
            
            checklib;
            nsp = tp.nSpecies;
            yy = zeros(1, nsp);
            pt = libpointer('doublePtr', yy);
            calllib(tp.lib, 'thermo_getCharges', ...
                    tp.tp_id, nsp, pt);
            e = pt.Value; 
        end
        
        function amu = atomicMasses(tp)
            % Get the atomic masses of the elements.
            %
            % :return: 
            %    Vector of element atomic masses. Unit: kg/kmol
            
            checklib;
            nel = tp.nElements;
            aa = zeros(1, nel);
            pt = libpointer('doublePtr', aa);
            calllib(tp.lib, 'thermo_getAtomicWeights', ...
                    tp.tp_id, nel, pt);
            amu = pt.Value;
        end
        
        function nm = speciesName(tp, k)
            % Get the name of a species given the index.
            %
            % :param k: 
            %    Scalar or array of integer species index.
            % :return: 
            %    Cell array of strings species name. 
            [m, n] = size(k);
            nm = cell(m, n);
            for i = 1:m
                for j = 1:n
                    ksp = k(i, j)-1;
                    buflen = calllib(tp.lib, 'thermo_getSpeciesName', ...
                                     tp.tp_id, ksp, 0, '');
                    if buflen > 0
                        aa = char(zeros(1, buflen));
                        pt = libpointer('voidPtr', int8(aa));
                        pt2 = libpointer('cstring', aa);
                        out_buf = calllib(tp.lib, 'thermo_getSpeciesName', ...
                                          tp.tp_id, ksp, buflen, pt);
                        out2_buf = calllib(tp.lib, 'thermo_getSpeciesName', ...
                                       tp.tp_id, ksp, buflen, pt2);
                        nm = pt.Value; 
                    end
                end
            end
        end
        
        %% Set thermal properties
        
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

    end
end