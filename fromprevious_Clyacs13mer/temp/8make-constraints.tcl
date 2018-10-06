set out1 clya_13mercs_kcl_HEAVY.pdb
set out2 clya_13mercs_kcl_CA.pdb

mol delete all
mol load psf clya-13mercs_kcl.psf pdb clya-13mercs_kcl.pdb
set all [atomselect top all]

$all set beta 0
set sel [atomselect top "protein noh"]
$sel set beta 1
$all writepdb $out1

$all set beta 0
$all set occupancy 0
set sel [atomselect top "name CA"]
$sel set beta 1
$all writepdb $out2


################################################
# measure for namd cellBasisVector1 /cellOrigin
################################################

measure minmax $all
measure center $all
