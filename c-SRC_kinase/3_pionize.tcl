mol delete all
mol load psf 1y57protein_wb.psf pdb 1y57protein_wb.pdb

# calculte protein charge
set everyone [atomselect top all] 
set protein [atomselect top protein] 
set proteincharge [eval vecadd [$protein get charge]] 
set systemcharge [eval vecadd [$everyone get charge]]

set proteinchargeround  [expr {int(floor($proteincharge+0.5))}]

$everyone delete 
$protein delete 

set conc 1.0
set water [atomselect top "name OH2"]

set num [expr {int(floor($conc*[$water num]/(55.523 + 2.0*$conc) + 0.5))}]

set npot [expr {$num-$proteinchargeround}]

package require autoionize

autoionize -psf 1y57protein_wb.psf -pdb 1y57protein_wb.pdb -nions [list "POT $npot" "CLA $num"] -o 1y57protein_wb_kcl