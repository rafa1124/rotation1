# generate lipid psf 
# both doesn't work
# 1

#############################
# method 2
package require psfgen 
resetpsf
topology /home/yifei6/Downloads/nanopore-protocols/c32b1/toppar/top_all27_prot_lipid.rtf
topology /home/yifei6/Downloads/nanopore-protocols/charmm36.nbfix/toppar_all36_dphpc.str

pdbalias residue DPhPC DFPCL
mol delete all
mol load pdb membrane_cut.pdb
set segnames [lsort -unique [[atomselect top all] get segname]]
foreach segname $segnames {
  [atomselect top "segname $segname"] writepdb membrance_cut_$segname.pdb
}
foreach segname $segnames {
  segment $segname {
    auto none
    first none
    last none
    pdb membrance_cut_$segname.pdb
  }
  coordpdb membrance_cut_$segname.pdb $segname
}
writepsf myfile.psf
writepdb myfile.pdb
