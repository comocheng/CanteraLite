function m = AxisymmetricFlow(gas, id)
    % Create an axisymmetric flow domain. 
    % :param id:
    %    String ID of the flow.
    m = Domain1D(1, gas);
    if nargin == 1
        m.setID('flow');
    else
        m.setID(id);
    end
end