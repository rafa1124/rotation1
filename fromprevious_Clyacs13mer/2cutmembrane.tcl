# cut membrane and genertate membrane psf
#############################

$all2 set beta 1
set seltext "same residue as ((x < 70  and x > -70) and (y < 70 and y >-70))"
set sel [atomselect top $seltext]
$sel set beta 0
set badmembrane [atomselect top " beta = 1"]
set badseglist [$badmembrane get segid]
set badreslist [$badmembrane get resid]

mol delete all 
package require psfgen 
resetpsf 
#topology /Users/yifeili/Desktop/rotation1/nanopore-protocols/charmm_c32b1/toppar/top_all27_lipid.rtf 

topology /home/yifei6/Downloads/nanopore-protocols/charmm36.nbfix/toppar_all36_dphpc.str

coordpdb membrane.pdb 

foreach segid $badseglist resid $badreslist {
	delatom $segid $resid 
	} 

writepdb membrane_cut.pdb 
mol load pdb membrane_cut.pdb 

set segnames [lsort -unique [[atomselect top all] get segname]]
foreach segname $segnames {
  [atomselect top "segname $segname"] writepdb membrane_cut_$segname.pdb
}
foreach segname $segnames {
  segment $segname {
    auto none
    first none
    last none
    pdb membrane_cut_$segname.pdb
  }
  coordpdb membrane_cut_$segname.pdb $segname
}
writepsf membrane_cut.psf
writepdb membrane_cut.pdb



writepsf membrane_cut.psf
