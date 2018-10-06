# in terminal 
# solvate -t 3 -n 8 -w clya-cs-13mer solvate_raw
# genrate water psf for solvate_raw 
package require psfgen 
resetpsf
topology /home/yifei6/Downloads/nanopore-protocols/c32b1/toppar/top_all27_prot_lipid.rtf
pdbalias residue HOH TIP3
pdbalias atom TIP3 O OH2
pdbalias atom TIP3 OW OH2
pdbalias atom ILE CD1 CD
pdbalias residue HIS HSE

# mol delete all
mol load pdb solvate_raw.pdb
set segnames [lsort -unique [[atomselect top all] get segname]]
foreach segname $segnames {
  [atomselect top "segname $segname"] writepdb solvate_$segname.pdb
}
foreach segname $segnames {
  segment $segname {
    auto none
    first none
    last none
    pdb solvate_$segname.pdb
  }
  coordpdb solvate_$segname.pdb $segname
}
writepsf solvate.psf
writepdb solvate.pdb
