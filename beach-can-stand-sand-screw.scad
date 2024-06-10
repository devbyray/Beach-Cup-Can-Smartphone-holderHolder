// ===== INFORMATION ===== //
// Author: https://makerworld.com/en/@3DbyRayRay
// Website: https://www.3dray.nl/
// Link: ***
// License: Creative Commons Attribution-Noncommercial-Share Alike

// preview[view:south west, tilt:side]
use <bolts-and-nuts.scad>;

$fn = 100;

/* [Bold Settings] */
// Bold size (mm)
bold_size = 15;

/* [General Can Holder Settings] */
// Can wall thickness (mm)
can_wall_thickness = 7;


/* [Small Can Holder Settings] */
// Can height (mm)
can_height = 60;
// Can inner width (mm)
can_inner_width = 55;

/* [Big Can Holder Settings] */
// Can height (mm)
can_big_height = 80;
// Can inner width (mm)
can_big_inner_width = 68;

/* [Big Cup + Phone Holder Settings] */
// Can height (mm)
cup_big_height = 80;
// Can inner width (mm)
cup_big_inner_width = 90;

/* [Beach Screw Settings] */
beach_screw_settings = 80;

translate([0, -100, beach_screw_settings + 10])
beachScrew();

// Small Can Holder
translate([0, 0, 15])
canHolder(can_inner_width / 2, can_wall_thickness / 2, can_height);

// Big Can Holder
translate([100, 0, 15])
canHolder(can_big_inner_width / 2, can_wall_thickness / 2, can_big_height);


// Big Cup + Phone Holder
translate([200, 0, 15])
canHolderWithPhoneSpace(cup_big_inner_width / 2, can_wall_thickness / 2, cup_big_height);


module beachScrew() {
	// Beach screw
	difference() {
		union() {
		  translate([1, 0, 0])
			rotate([0, 180, 0])
			AugerThread(24, 7, beach_screw_settings, 12, tooth_angle=10, tip_height=20);
		}

		translate([3,-30,-90])
		cube([30, 60, 160]);

	}


	// Screw platteau
	difference() {
		
		union() {
			translate([0, 0, 0])
			rotate([0,0,0])
			linear_extrude(6)
			circle(28);
		}

		translate([3,-30,-90])
		cube([30, 60, 160]);	
		
	}


	// Platteau bold
	difference() {

		translate([-3, 0, -9])
		MetricBolt(bold_size, bold_size - 12);
		
		translate([-40,-30,-20])
		cube([60, 60, 26]);
	}
}

module canHolderWithPhoneSpace(inner_width, wall_thickness, height) {
	
	union() {
		
		canHolder(inner_width, wall_thickness, height, false);
		
		translate([inner_width / 2, 0, 0])
		difference() {
			translate([-3, 0, 0])
			MetricNut(bold_size);
				
			translate([-3, 0, 5])
			rotate([0,0,0])
			linear_extrude(30)
			circle(inner_width);			
		}
		
		translate([-3,- inner_width - 1,5])
		difference() {
			minkowski() {
				cube([inner_width * 2 + 4, inner_width * 2 + 2, height]);
				sphere(2);
			}
			
			
			minkowski() {
				translate([-2,2,4])
				cube([inner_width * 2 - (wall_thickness * 4) + 16, inner_width * 2 - (wall_thickness * 4) + 11, height]);
				sphere(2);

			}
			
			
			minkowski() {
				// Inner space for can
				translate([0,inner_width + 1, 5])
				rotate([0,0,0])
				linear_extrude(height)
				circle(inner_width);
				
				sphere(2);

			}
		}
	}
	
}


module canHolder(inner_width, wall_thickness, height, show_bold = true) {
	union() {
		difference() {
			minkowski() {
				// Outside for can
				translate([-3, 0, 5])
				rotate([0,0,0])
				linear_extrude(height)
				circle(inner_width + wall_thickness);
				
				sphere(2);
				
			}

			// Inner space for can
			minkowski() {
				translate([-3, 0, 11])
				rotate([0,0,0])
				linear_extrude(height)
				circle(inner_width);
					
				sphere(2);
				
			}
		}
		
		rotate_extrude()
		translate([-3, 0, 40])
		rotate([0,90,0])
		#difference() {
			translate([0,0,0])
			square([inner_width, inner_width]);
			
			translate([0,0,0])
			circle(inner_width);
			
			
			
		}
		
		if(show_bold) {
			difference() {
				translate([-3, 0, 0])
				MetricNut(bold_size);
					
				translate([-3, 0, 5])
				rotate([0,0,0])
				linear_extrude(30)
				circle(inner_width);			
			}
		}
	}
}

function half(input) = input / 2;
	
module circleClip() {
	difference() {
		topCircle();
		
		translate([-4, 0, 16])
		rotate([0,90,0])
		linear_extrude(8)
		circle(6);
		
		translate([-4, -20, 16])
		rotate([0,90,0])
		linear_extrude(8)
		circle(4);

		translate([-4, 20, 16])
		rotate([0,90,0])
		linear_extrude(8)
		circle(4);
		
		translate([-4, 0, 40])
		rotate([0,90,0])
		linear_extrude(8)
		circle(4);
		
		translate([-4, -23, 15])
		minkowski(){
			cube([10,46,2],center=false);
			rotate([90,0,90]) cylinder(h=10,r=1);
		}
		
		translate([0, 0, -10])
		rotate([0,0,0])
		linear_extrude(10)
		circle(40);
	}
}

module topCircle() {
	translate([-3, 0, 20])
	rotate([0,90,0])
	linear_extrude(6)
	circle(30);
}


