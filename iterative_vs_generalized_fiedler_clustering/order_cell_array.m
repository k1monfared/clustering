function ordered_C = order_cell_array(C,a)
    %C a cell of lists
    %a a particular order of numel(C) elements
    
    ordered_C = cell(1,numel(a));
    for o = 1:numel(a)
        ordered_C{o} = C{a(o)};
    end
end