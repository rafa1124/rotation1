##### combine the water membrane and protein
mol delete all
resetpsf
readpsf clya-cs-13mer.psf
coordpdb clya-cs-13mer.pdb
readpsf membrane_cut.psf
coordpdb membrane_cut.pdb
readpsf solvate.psf
coordpdb solvate.pdb
writepsf protmemwater_overlap.psf
writepdb protmemwater_overlap.pdb
mol load psf protmemwater_overlap.psf pdb protmemwater_overlap.pdb
