function r = IdealGasConstPressureReactor(contents)
    % Create a constant pressure reactor object with an ideal gas.
    % Pressure is held constant. The volume is not a state variable, but
    % instead takes on whatever value is consistent with holding the
    % pressure constant.
    %
    %: param contents:
    %    Contents of the reactor of class 'Solution'.
    
    if nargin == 0
        contents = 0;
    end
    r = Reactor(contents, 'IdealGasConstPressureReactor');
end