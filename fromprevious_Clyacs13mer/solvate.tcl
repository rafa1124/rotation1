package require solvate
solvate protmem.psf protmem.pdb -o clya-as_raw -minmax {{-100 -100 -100} {100 100 100}}

#set bad [atomselect top {same residue as segname "WT[0-9]+" and abs(z) < 27}]
mol delete all
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
