function y = canonical_polar(y)
    %given a vector y as the phases of a bunch of oscillators this 
    %   first makes y(1) to be zero
    %   second mods everything by 2*pi
    %   third makes y(2) to be in the upper half plane
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    y = y - y(1); 
    if sin(y(2)) < 0
        y = -y;
    end
    y = mod(y,2*pi);
end