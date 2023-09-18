# Choose potential
pair_style      lj/cut/coul/long 15 15
special_bonds   lj/coul 0.0 0.0 0.0
pair_modify     mix arithmetic
bond_style	harmonic
angle_style	harmonic
dihedral_style opls
improper_style harmonic

# Setup neighbor style
kspace_style    pppm 1e-4
neighbor        5.0 bin
neigh_modify    every 1 check yes page 150000 one 10000
bond_coeff      1 554.135 1 # agua Ow-Hw
bond_coeff      2 554.1349 1.0 # arcilla oh-ho  
bond_coeff      3 554.1349 1.0 # arcilla ohs-ho
bond_coeff     4 469.0 1.4 # grafeno C-C
bond_coeff     5 367.0 1.08 # grafeno C-H
#bond_coeff      4 495 0.9450 # ox. silica H-O
#bond_coeff      5 285 1.68   # ox. silica O-Si
angle_coeff     1 45.7696 109.4700 # agua
angle_coeff     2 30.0 109.47 # arcilla metal-oh-ho  
angle_coeff     3 30.0 109.47 # arcilla metal-ohs-ho
angle_coeff    4 63.0 120.0 # grafeno C-C-C
angle_coeff    5 35.0 120.0 # grafeno C-C-H
#angle_coeff     4 100 109.5 # ox. silica O-Si-O
#angle_coeff     5 100 149.0 # ox. silica Si-O-Si
#angle_coeff     6 50 115.0  # ox. silica H-O-Si
dihedral_coeff 1 0.0 7.25 0.0 0.0 # grafeno C-C-C-C
dihedral_coeff 2 0.0 7.25 0.0 0.0 # grafeno C-C-C-H
dihedral_coeff 3 0.0 7.25 0.0 0.0 # grafeno H-C-C-H
improper_coeff 1 5.0 180.0 # grafeno C-C-C-C
improper_coeff 2 5.0 180.0 # grafeno C-C-H-C

#fix            SHAKE all shake 1e-4 20 0 b 1 2 3 a 1 2 3 # Lodo base
#fix             SHAKE all shake 1e-4 20 0 b 1 2 3 4 a 1 2 3 4 5 6 # Ox. silica
fix            SHAKE all shake 1e-4 20 0 b 1 2 3 5 a 1 2 3 4 5 # Grafeno

# Setup output
fix avp all ave/time  ${nevery} ${nrepeat} ${nfreq} c_thermo_press mode vector
thermo		${nthermo}
thermo_style custom step atoms temp press pe ke etotal evdwl ecoul ebond eangle density f_avp[1] f_avp[2] f_avp[3] f_avp[4] f_avp[5] f_avp[6]
thermo_modify norm no

# Setup MD
timestep ${timestep}
fix 4 all nve
if "${thermostat} == 1" then &
   "fix 5 all langevin ${temp} ${temp} ${tdamp} ${seed}"