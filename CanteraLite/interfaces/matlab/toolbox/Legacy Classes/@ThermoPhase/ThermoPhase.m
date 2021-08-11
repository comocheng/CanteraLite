function t = ThermoPhase(src, id)
    if nargin > 2
        error('ThermoPhase expects 1 or 2 input arguments.');
    end
    if nargin == 1
        id = '-';
    end
    t.owner = 1;
    [class_id, job_id] = FunctionDictionary('thermo_newFromFile');
    t.tp_id = thermo_get(class_id, job_id, 0, src, id)
%     if t.tp_id < 0
%         error(geterr);
%     end
    t = class(t, 'ThermoPhase');
end