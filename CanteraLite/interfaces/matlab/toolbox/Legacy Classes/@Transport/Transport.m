% A dummy transport function with empty output
function tr = Transport(th, model, loglevel)
    tr.id = 0;
    tr = class(tr, 'Transport');
end