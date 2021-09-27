classdef Kinetics_C < handle
    properties
        kin_owner
        kin_id
    end
    properties(Constant = true)
        lib = 'cantera_shared'
    end
    methods
        % Kinetics class constructor
        function kin = Kinetics_C(ph, src, id, n1, n2, n3, n4)
            checklib;
            % indices for bulk phases in a heterogeneous mechanism
            inb1 = -1;
            inb2 = -1;
            inb3 = -1;
            inb4 = -1;
            if nargin == 2
                id = '-';
            end
            kin.kin_owner = 1;
            % get the integer indices used to find the stored objects
            % representing the phases participating in the mechanism
            iph = ph.tp_id;
            if nargin > 3
                inb1 = n1.tp_id;
                if nargin > 4
                    inb2 = n2.tp_id;
                    if nargin > 5
                        inb3 = n3.tp_id;
                        if nargin > 6
                            inb4 = n4.tp_id;
                        end
                    end
                end
            end
            kin.kin_id = calllib(kin.lib, 'kin_newFromFile', src, id, ...
                                 iph, inb1, inb2, inb3, inb4);
        end
        
        % Delete the kernel object
        function kin_clear(kin)
            checklib;
            calllib(kin.lib, 'kin_del', kin.kin_id);
        end
        
    end
end