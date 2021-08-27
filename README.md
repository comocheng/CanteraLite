# CanteraLite Direct-C
A proof of concept for Cantera Matlab Toolbox

This project aims to build a mockup of Cantera Matlab Toolbox with modern object-oriented programming structures. 

This version of the Toolbox directly calls functions within the Cantera shared library using the _calllib_ command in Matlab. It currently contains two .m scripts to create _Solution_ type objects containing 3 classes: _ThermoPhase_, _Kinetics_, and _Transport_. Currently only the _ThermoPhase_ class is functional. See readme.txt for the list of functionalities supported in _ThermoPhase_. 
