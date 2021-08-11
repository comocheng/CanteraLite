function n = testfunc()
    class_name = 'thermo_';
    st = dbstack;
    n = [class_name, st.name];
end