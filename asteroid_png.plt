# Setting
reset
set nokey
set term png size 720, 720
system 'mkdir png'

set size ratio -1
set samples 1e4
set xl "{/TimesNewRoman:Italic=24 x}"
set yl "{/TimesNewRoman:Italic=24 y}"
set tics font 'TimesNewRoman,20'
L = 6.
set xr[-L:L]
set yr[-L:L]
set xtics -L, L/2, L
set ytics -L, L/2, L
set grid

# Asteroid
a = 5.
x(t) = a*(cos(t))**3
y(t) = a*(sin(t))**3
X(t) = 3*a/4*cos(t)
Y(t) = 3*a/4*sin(t)

# Parameter
png = 0
cut = 20
n = 0.          # [rad]
d2r = pi/180.   # [deg] -> [rad]
dn = 2*d2r/cut  # [rad]
N = 360*d2r # [rad]
R = 0.1			# radius
r = R*0.1       # trajectory

# Plot
set obj 1 circ at 0, 0 size a fs transparent border lc rgb 'black'

do for [j=1:4]{
    if(j%2 != 0){   # Turn old objects smaller
        unset obj N/dn+3
        set obj 3 circ  at x(n), y(n) size R fc rgb 'royalblue' fs solid front
        
        do for [i=1:N/dn]{
    	    n = n + dn
            set obj i+2 size r
    	    set obj i+3 circ at x(n), y(n) size R fc rgb 'royalblue' fs solid front
    	    if(i%cut == 0){
    	    	set obj 2 circ at X(n), Y(n) size a/4 fs transparent border lc rgb 'black'
    	    	set arrow 1 nohead from X(n), Y(n) to x(n), y(n) lc rgb 'red'
    	    	png = png + 1
    	    	set output sprintf("png/img_%05d.png", png)
                plot 1/0
            }
        }
    } else {        # Remove old objects
        set obj N/dn+3 size r
        do for [i=1:N/dn]{
    	    n = n + dn
            unset obj i+2
    	    set obj i+3 circ at x(n), y(n) size R fc rgb 'royalblue' fs solid front
    	    if(i%cut == 0){
    	    	set obj 2 circ at X(n), Y(n) size a/4 fs transparent border lc rgb 'black'
    	    	set arrow 1 nohead from X(n), Y(n) to x(n), y(n) lc rgb 'red'
    	    	png = png + 1
    	    	set output sprintf("png/img_%05d.png", png)
                plot 1/0
            }
        }
    }
}

set out