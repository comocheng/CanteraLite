function s = Solution(src, id, trans)
    if nargin == 1
        id = '-';
    end
    t = ThermoPhase_New(src, id);
    k = Kinetics(t, src, id);
    s.kin = k;
    s.th = t;
    if nargin == 3
        if (strcmp(trans, 'default') || strcmp(trans, 'None')...
            || strcmp(trans, 'Mix') || strcmp(trans, 'Multi'))
            tr = Transport(t, trans, 0);
        else
            error('Unknown transport modelling specified.')
        end
    else
        tr = Transport(t, 'default', 0);
    end
    s.tr = tr;
    s = class(s, 'Solution', t, k, tr);
end