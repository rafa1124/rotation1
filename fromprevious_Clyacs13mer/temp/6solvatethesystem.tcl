package require solvate
solvate protmemwater.psf protmemwater.pdb -o clya-13mercs_raw -minmax {{-87 -87 -90} {87 87 90}}

set bad [atomselect top {same residue as segname "WT[0-9]+" and \
(z < -27.64 and z >-70.99)}]

resetpsf
readpsf clya-13mercs_raw.psf
coordpdb clya-13mercs_raw.pdb
foreach segid [$bad get segid] resid [$bad get resid] name [$bad get name] {
  delatom $segid $resid $name
}
writepsf clya-13mercs_raw2.psf
writepdb clya-13mercs_raw2.pdb
mol delete all
mol load psf clya-13mercs_raw2.psf pdb clya-13mercs_raw2.pdb

