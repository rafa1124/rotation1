package require psfgen
resetpsf
topology ../../charmm36.nbfix/toppar_all36_dphpc.str
topology ../../charmm36.nbfix/top_all36_lipid.rtf
topology ../../charmm36.nbfix/top_all36_prot.rtf
topology ../../charmm36.nbfix/top_water_ions.rtf

mol load psf protmemwater_overlap.psf pdb protmemwater_overlap.pdb
set bad [atomselect top {same residue as \
  ((resname DFPC and (within 2 of protein or sqrt(x^2+y^2) < 40)))}]
# line 1: cut the lipid close to protein and with in the stem hole
# line 2: cut the water within the nanopore stem hole
# line 3: cut the water in the lipid convert in to variable later DO NOT USE NUMERIACAL VALUE!
resetpsf
readpsf protmemwater_overlap.psf
coordpdb protmemwater_overlap.pdb
foreach segid [$bad get segid] resid [$bad get resid] name [$bad get name] {
  delatom $segid $resid $name
}
writepsf protmemwater.psf
writepdb protmemwater.pdb
mol delete all
mol load psf protmemwater.psf pdb protmemwater.pdb

# 
# \
#   or (segname "W[0-9]{3}" and (within 2 of protein)) \
#   or (segname "W[0-9]{3}" and (z < 23.5 and z >-21.5)) \
#   or (abs(x) > 95.0 or abs(y) > 95.0)