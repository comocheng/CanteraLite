function gas = GRI30(tr)
    if nargin == 0
        gas = Solution_C('gri30.yaml', 'gri30');
    elseif nargin == 1
        if strcmp(tr, 'None')
            gas = Solution_C('gri30.yaml', 'gri30', 'None');
        elseif strcmp(tr, 'Mix')
            gas = Solution_C('gri30.yaml', 'gri30', 'Mix');
        elseif strcmp(tr, 'Multi')
            gas = Solution_C('gri30.yaml', 'gri30', 'Multi')
        else
            error('Unknown transport specified. "None", "Mix", or "Multi" are supported.')
        end
    else
        error('Wrong number of arguments.');
end