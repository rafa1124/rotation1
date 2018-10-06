# chose protein
mol load pdb 1y57.pdb
set 1y57 [atomselect top protein] 
#move and rotate in order to align with nanopore
$1y57 moveby [vecinvert [measure center $1y57 weight mass]]
$1y57 move [trans axis y 75 deg]
$1y57 moveby "0 0 90"

$1y57 writepdb 1y57protein.pdb

# generate psf
package require psfgen
resetpsf
topology ../../charmm36.nbfix/top_all36_prot.rtf

pdbalias residue HOH TIP3
pdbalias atom TIP3 O OH2
pdbalias atom TIP3 OW OH2
pdbalias atom ILE CD1 CD
pdbalias residue HIS HSE
segment U {pdb 1y57protein.pdb}
coordpdb 1y57protein.pdb U 
guesscoord 
writepdb 1y57protein.pdb 
writepsf 1y57protein.psf

set all [atomselect top all]
measure minmax $all
mol load psf 1y57protein.psf pdb 1y57protein.pdb
#result: {-31.09000015258789 -38.50899887084961 56.801998138427734} 		
#{30.200000762939453 37.79100036621094 147.7740020751953}

