% A dummy kinetics function with empty output
function k = Kinetics(ph, src, id)
    k.owner = 1;
    k = class(k, 'Kinetics');
end