package require autopsf
package require mutator

set filelist [glob *_ss.pdb]
set sortedfilelist [lsort -dictionary $filelist]
foreach file $sortedfilelist {
set filewhext [file rootname $file]
mol new $file
set strmolid [molinfo top]
autopsf -mol $strmolid -protein -top top_all22_prot.inp
mutator -psf ${filewhext}_autopsf.psf -pdb ${filewhext}_autopsf.pdb -o mutout -ressegname P1 -resid 372 -mut ALA -FEP ${filewhext}_fep
resetpsf
mol delete all
mol load pdb ${filewhext}_fep.fep
set sel [atomselect top all]
$sel writepdb ${filewhext}_fep.pdb
resetpsf
mol delete all
file rename ${filewhext}_fep.fep.psf ${filewhext}_fep.psf
}

#mutator -psf <psffile> -pdb <pdbfile> -o <prefix>  -ressegname <targetresiduesegname> -resid <targetresid> -mut <resname> -FEP <prefix2>
