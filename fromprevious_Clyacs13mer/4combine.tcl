##### combine the water membrane and protein
mol delete all
resetpsf
readpsf membrane.psf
coordpdb membrane.pdb
readpsf clya-cs-13mer_moved.psf
coordpdb clya-cs-13mer_moved.pdb
#readpsf membrane_cut.psf
#coordpdb membrane_cut.pdb
#readpsf solvate.psf
#coordpdb solvate.pdb
writepsf protmemwater_overlap.psf
writepdb protmemwater_overlap.pdb
mol load psf protmemwater_overlap.psf pdb protmemwater_overlap.pdb
mol load psf membrane.psf pdb membrane.pdb
