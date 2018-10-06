mol load pdb 1y57protein.pdb
set 1y57 [atomselect top "backbone and resid 84 to 134" ]
mol load pdb 2src.pdb
set 2src [atomselect top "backbone and resid 84 to 134"] 

# align two proteins 
set M [measure fit $2src $1y57]
set 2srcall [atomselect top protein] 
$2srcall move $M
$2srcall moveby "0 -20 0"
$2srcall writepdb 2srcprotein.pdb

mol delete all
# generate psf
mol load pdb 2srcprotein.pdb
package require psfgen
resetpsf
topology ../../charmm36.nbfix/top_all36_prot.rtf
topology ../../charmm36.nbfix/top_all36_na.rtf
topology ../../charmm36.nbfix/top_water_ions.rtf
topology ../../toppar/stream/prot/toppar_all36_prot_na_combined.str

# PTR is O-PHOSPHOTYROSINE TYR 
pdbalias residue HOH TIP3
pdbalias residue PTR TYR
pdbalias atom TIP3 O OH2
pdbalias atom TIP3 OW OH2
pdbalias atom ILE CD1 CD
pdbalias residue HIS HSE
segment U {pdb 2srcprotein.pdb}
patch TP2 U:527
regenerate angles dihedrals
coordpdb 2srcprotein.pdb U 
guesscoord 
writepdb 2srcprotein.pdb 
writepsf 2srcprotein.psf

set all [atomselect top all]
measure minmax $all
measure center $all
mol load psf 2srcprotein.psf pdb 2srcprotein.pdb

#result: {-21.559999465942383 -30.71500015258789 54.39099884033203} {32.17499923706055 30.663999557495117 132.5290069580078}
#7.089771270751953 3.181511640548706 92.43480682373047
