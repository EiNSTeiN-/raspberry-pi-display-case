
display_height = 111.5;
display_width = 194;

module screw_pad() {
	difference() {
		hull() {
			translate([(-6/2),-8/2,0]) cube([6,8,2]);
			translate([-15/2,-8/2,0]) cube([15,8,0.1]);
		}
		translate([0,0,-1]) cylinder(h=5,r=3/2, $fn=50);
	}
}

module screw_pads() {
	translate([-display_height/2,-display_width/2,6.5]) color([128,128,128]/255) {
		translate([22.5-3,34.5-5,0]) rotate([0,0,90]) screw_pad();
		translate([22.5-3+66,34.5-5,0]) rotate([0,0,90]) screw_pad();
		translate([22.5-3,34.5-5+126,0]) rotate([0,0,90]) screw_pad();
		translate([22.5-3+66,34.5-5+126,0]) rotate([0,0,90]) screw_pad();

		translate([27,60,0]) rotate([0,0,0]) screw_pad();
		translate([27,60+58.5,0]) rotate([0,0,0]) screw_pad();
		translate([27+49,60,0]) rotate([0,0,0]) screw_pad();
		translate([27+49,60+58.5,0]) rotate([0,0,0]) screw_pad();
	}
}

module display() {
	corner = 8;
	// glass panel
	difference() {
		translate([-display_height/2+corner,-display_width/2+corner,0]) color([0,0,0]) minkowski() {
			cube([display_height-(corner*2), display_width-(corner*2), 1]);
			cylinder(r=corner,h=0.1);
		}
		%translate([-display_height/2+12,-display_width/2+19,0]) cube([display_height-13-11, display_width-19-19, 1]);
	}
	// touchscreen
	color([0,0,128]/255) translate([-display_height/2+7.5,-display_width/2+16.5,1.5]) cube([display_height-6-7.5, display_width-4.5-16.5, 1.5]);
	// LCD metal box
	color([128,128,128]/255) translate([-display_height/2+6.5,-display_width/2+11.5,2.5]) cube([display_height-6.5-3.5, display_width-11.5-15, 4]);

	// ribbon cable
	color([255,140,0]/255) translate([display_height/2-32,-display_width/2+76,3]) cube([30,40,5]);

	// screw pads
	screw_pads();

	// PCBs
	translate([-display_height/2,-display_width/2,8.5]) {
		// bottom
		translate([23.5,57,0]) color([34,139,34]/255) cube([56.5,65,1]);

		// foot
		translate([27,60,1]) color([192,192,192]/255) cylinder(h=12,r=6/2,$fn=6);
		translate([27,60+58.5,1]) color([192,192,192]/255) cylinder(h=12,r=6/2,$fn=6);
		translate([27+49,60,1]) color([192,192,192]/255) cylinder(h=12,r=6/2,$fn=6);
		translate([27+49,60+58.5,1]) color([192,192,192]/255) cylinder(h=12,r=6/2,$fn=6);

		// top
		translate([23.5,57-20,13]) color([34,139,34]/255) cube([56.5,85,1]);

		// network
		translate([23.5+38,57-20-2,0]) {
			color([192,192,192]/255) cube([16,21,13]);
			translate([2,-0.2,2.5]) color([0,0,0]/255) cube([12,21,9.5]);
		}

		// usb
		translate([23.5+20,57-20-2,-2]) {
			color([192,192,192]/255) cube([16,21,15]);
			translate([2,-0.2,1]) color([0,0,0]/255) cube([12,21,4.5]);
			translate([2,-0.2,9.5]) color([0,0,0]/255) cube([12,21,4.5]);
		}
		translate([23.5+2.5,57-20-2,-2]) {
			color([192,192,192]/255) cube([16,21,15]);
			translate([2,-0.2,1]) color([0,0,0]/255) cube([12,21,4.5]);
			translate([2,-0.2,9.5]) color([0,0,0]/255) cube([12,21,4.5]);
		}
	}
}
