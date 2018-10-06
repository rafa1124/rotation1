############################################################################################
# bulid 13mer
############################################################################################

# no need to rotate or repostion of this protein, it is already aligned by previous work

mol load pdb clya-cs-13mer.pdb psf clya-cs-13mer.psf
set all [atomselect top all]
measure minmax $all 
set m [measure minmax $all]
set xUp [lindex $m end end-2]
set xDown [lindex $m end-1 end-2]
set yUp [lindex $m end end-1]
set yDown [lindex $m end-1 end-1]
set z [lindex $m end-1 end]

#### result: {-62.34303665161133 -61.26203155517578 -75.57212829589844} {62.30195999145508 62.765968322753906 68.29187774658203}

###### in shell 
###### solvate -t 3 -n 8 -w clya-cs-13mer solvate_raw
#  overlap center. In this system, it is already overlaped

mol load pdb membrane.pdb psf membrane.psf
set all2 [atomselect top all]
$all2 moveby [vecinvert [measure center $all2 weight mass]]

set m2 [measure minmax $all2]
set z2 [lindex $m2 end-1 end]

####result:{-114.31362915039063 -119.1385498046875 -30.512773513793945} {117.11237335205078 113.14144897460938 32.325225830078125}

set zdiff [expr $z-$z2-5]

# move down the lipid align with the bottom of clya
set vector [list 0 0 $zdiff]
$all2 moveby $vector
$all2 writepdb mem_moved.pdb
mol load pdb mem_moved.pdb
