package require solvate
solvate protmemwater.psf protmemwater.pdb -o clya-13mercs_raw -minmax {{-110 -110 -45} {110 110 140}}

set bad [atomselect top {same residue as segname "WT[0-9]+" and \
(z < 23.5 and z >-21.5) }]
package require psfgen 
resetpsf
topology ../../charmm36.nbfix/toppar_all36_dphpc.str
topology ../../charmm36.nbfix/top_all36_lipid.rtf
topology ../../charmm36.nbfix/top_all36_prot.rtf
topology ../../charmm36.nbfix/top_water_ions.rtf

readpsf clya-13mercs_raw.psf
coordpdb clya-13mercs_raw.pdb
foreach segid [$bad get segid] resid [$bad get resid] name [$bad get name] {
  delatom $segid $resid $name
}
writepsf clya-13mercs_raw2.psf
writepdb clya-13mercs_raw2.pdb
mol delete all
mol load psf clya-13mercs_raw2.psf pdb clya-13mercs_raw2.pdb

# lipid minmax
#{-114.31400299072266 -119.13899993896484 -30.51300048828125} 
#{117.11199951171875 113.14099884033203 32.32500076293945}
