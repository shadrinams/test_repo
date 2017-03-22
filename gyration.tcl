proc cut_ca {name type} {

set root "/../"
cd "$root/$name/"
set file [open "gyration_[list $type].dat" w]
puts $file "time|radius of gyration"
puts $file "ps|A"


mol new [list $type]_prot.psf
mol addfile [list $type]_prot.pdb
mol addfile md_[list $type]_whole.xtc waitfor all step 5

set sel [atomselect top "protein and noh"]
set nf [molinfo top get numframes]

for {set i 0} {$i<$nf} {incr i} {
	$sel frame $i
	set gyr [measure rgyr $sel weight mass]
	set time [expr ($i*10)]
	puts $file "$time|$gyr"
	}

mol delete top
close $file

}

