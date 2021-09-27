This Matlab Toolbox for Cantera serves as a proof of concept for direct C-library integration into Matlab. 

Move the toolbox_C folder into <installation folder to Cantera>\matlab. Then launch Matlab, navigate to the toolbox location, and add all folders and subfolders to path.

For first time users, open Load_Cantera.m. On Row 3, change cantera_root to <installation folder to Cantera>. 

To start using the toolbox, use the Load_Cantera command to load cantera_shared.dll into the memory. Then you could type either Air or GRI30 to start generating your gas object. 

Each Solution-C class object contains three classes: thermo, kinetics, and transport. The latter two are blank classes at this moment, but ThermoPhase has the following functionalities:
> Create a ThermoPhase class object from files.
> Display thermal properties. Simply type '<name of object>.thermo' without a semicolon or '<name of object>.thermo.display'.
> Get temperature, pessure, density, mole fractions, and mass fractions using property get methods. Type '<name of object>.thermo.T/P/rho/X/Y' to directly access those properties.
> Get molar density, mean molecular weight, # of elements/species, atomic masses of elements using regular Matlab methods. Type '<name of object>.thermo.<name of command>'.
> Set temperature, pressure, and density using property set methods. Type '<name of object>.thermo.T/P/rho = <value>' to directly set those properties. 
> Equilibrate the gas using '<name of object>.thermo.Equilibrate'. 

To stop using Cantera and purge all objects from memory, use Unload_Cantera command. 