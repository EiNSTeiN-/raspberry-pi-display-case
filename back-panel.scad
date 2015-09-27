include <display.scad>;

bezel_width = (display_width+4);
bezel_height = (display_height+4);

module rounded_screen(width, height, corner, thickness) {
	translate([-height/2+corner,-width/2+corner,0]) minkowski() {
		cube([height-(corner*2), width-(corner*2), thickness]);
		cylinder(r=corner,h=0.1);
	}
}

module bezel() {
  difference() {
    union() {
      difference() {
        union() {
          hull() {
            rounded_screen(display_width+4, display_height+4, 10, 2);
            translate([-display_height/2+3, -display_width/2+10, 0]) cube([display_height-6, display_width-20, 9]);
            translate([-display_height/2+10, -display_width/2+3, 0]) cube([display_height-20, display_width-6, 9]);
          }

        }
        union() {
          translate([0,0,-1]) rounded_screen(display_width, display_height, 8, 0.7+1);
          difference() {
            hull() {
              translate([0,0,1]) rounded_screen(display_width-4, display_height-4, 4, 2);
              translate([-display_height/2+5, -display_width/2+12, 0]) cube([display_height-10, display_width-24, 8]);
              translate([-display_height/2+12, -display_width/2+5, 0]) cube([display_height-24, display_width-10, 8]);
            }
            translate([40.5,-63+28+0.5-4,7]) cube([12,10+8,1]);
          }
          translate([-80/2,-150/2-1,0]) cube([80,150+1,10]);
        }
      }
      translate([-80/2,-150/2,7]) difference() {
        translate([-2,-4,-1]) cube([84,158,3]);
        translate([0,-1,-4]) cube([80,150+1,8]);

        // ribbon cable
        translate([55,53,-3]) cube([30,44,3]);
      }
      translate([-30-2,-94,5]) cube([56+4,8,4]);
    }

    translate([-30,-80,2]) cube([56,8,5]);
    translate([-30,-100,6.5]) cube([56,26,3]);

    // bottom usb
    hull() {
      translate([25,-63+28+0.5-2,7.5]) cube([30,10+4,0.1]);
      translate([25,-63+28+0.5-3,9.1]) cube([30,10+6,2]);
    }
  }
}

module screw_pad_hole(holes=1) {
  difference() {
    hull() {
      translate([(-7/2)-3,-9/2-1,0]) cube([7+6,11,2.1]);
      translate([-16/2-2+.5,-9/2-1,0]) cube([19,11,0.1]);
    }
    if(holes == 1) {
      translate([0,0,-1]) cylinder(h=10,r=6/2, $fn=50);
    }
  }
  if(holes == 1) {
    translate([0,0,-1]) cylinder(h=10,r=4.6/2, $fn=50);
  }
}

module screw_pad_holes() {
  translate([-display_height/2,-display_width/2,6.5]) color([128,128,128]/255) {
    translate([22.5-1.5,34.5-3,0]) rotate([0,0,90]) screw_pad_hole();
    translate([22.5-1.5+66,34.5-3,0]) rotate([0,0,90]) screw_pad_hole();
    translate([22.5-1.5,34.5-3+126,0]) rotate([0,0,90]) screw_pad_hole();
    translate([22.5-1.5+66,34.5-3+126,0]) rotate([0,0,90]) screw_pad_hole();

    translate([27,60,0]) rotate([0,0,0]) screw_pad_hole();
    translate([27,60+58.5,0]) rotate([0,0,0]) screw_pad_hole();
    *translate([27+49,60,0]) rotate([0,0,0]) screw_pad_hole();
    *translate([27+49,60+58.5,0]) rotate([0,0,0]) screw_pad_hole();
  }
}

module screw_pad_covers() {
  translate([-display_height/2,-display_width/2,6.5]) color([128,128,128]/255) {
    translate([22.5-1.5,34.5-3,0]) rotate([0,0,90]) screw_pad_hole(0);
    translate([22.5-1.5+66,34.5-3,0]) rotate([0,0,90]) screw_pad_hole(0);
    translate([22.5-1.5,34.5-3+126,0]) rotate([0,0,90]) screw_pad_hole(0);
    translate([22.5-1.5+66,34.5-3+126,0]) rotate([0,0,90]) screw_pad_hole(0);
  }
}

module back_box(height, width, thickness, roundness) {
  minkowski() {
    cube([height-roundness, width-roundness, thickness]);
    cylinder(r=roundness/2,h=0.1,$fn=50);
  }
}

module back() {
  union() {
    *translate([-80/2+.5,-150/2,0]) cube([80-1,150-1,400]);
    difference() {
      union() {
        hull() {
          translate([-80/2+.5,-150/2,7]) cube([80-1,150-1,0.1]);
          translate([-80/2+.5,-150/2,9]) cube([80-1,150-1,0.1]);
        }
        translate([-33,-60,9]) back_box(64,92,20,6);
        translate([27,12,7]) rotate([90,0,0]) intersection() {
          hull() {
            cylinder(r=10/2,h=25,$fn=50);
            translate([7,0,0]) cylinder(r=10/2,h=25,$fn=50);
          }
          cube([15,15,25]);
        }
        translate([0,0,2.5]) screw_pad_covers();

        translate([36,-72,9]) cube([14,13,2.1]);
        translate([36+12,-72,7]) cube([2,13,2.1]);

        translate([-52,-72,9]) cube([12,13,2.1]);
        translate([-52,-72,7]) cube([2,13,2.1]);

        translate([36,54,9]) cube([14,13,2.1]);
        translate([36+12,54,7]) cube([2,13,2.1]);

        translate([-52,54,9]) cube([12,13,2.1]);
        translate([-52,54,7]) cube([2,13,2.1]);
      }
      screw_pad_holes();
      translate([-34,-63,0]) cube([60,90,26]);
      translate([-30,-80,0]) cube([56,20,20]);
      translate([27,11,7]) rotate([90,0,0]) {
        hull() {
          cylinder(r=8/2,h=23,$fn=50);
          translate([7,0,0]) cylinder(r=8/2,h=23,$fn=50);
        }
      }
      // side connectors
      translate([25,-63+26.5,10]) minkowski() {
        cube([3.1,14,14]);
        rotate([0,90,0]) cylinder(r=1,h=0.1,$fn=40);
      }
      translate([25,-63+26.5+18,10+4]) minkowski() {
        cube([3.1,58-18,10]);
        rotate([0,90,0]) cylinder(r=1,h=0.1,$fn=40);
      }
      hull() {
        translate([25,-63+28+0.5-2,7.5]) cube([15,10+4,0.1]);
        translate([25,-63+28+0.5-3,9.1]) cube([15,10+6,2]);
      }
      // full size usb
      translate([2,20,9]) cube([16,10,9.5]);
      // micro sd
      translate([-5,20+9,22]) cylinder(r=15/2,h=10);

      translate([-50,-92,6]) cube([20,20,6]);

      translate([-35,-66,6.5]) union() {
        difference() {
          cube([7/2,7/2,5]);
          cylinder(r=7/2,h=5,$fn=50);
        }
        translate([7/2,-10+7/2,0]) cube([4,10,5]);
      }
    }
    translate([-52,-72,7]) cube([20.5,1,2.1]);
  }
}

module display_mode() {
  display();
  bezel();
  back();
}

module print_mode() {
  translate([0,0,9]) rotate([0,180,0]) bezel();
  translate([120,0,-7]) back();
}


display_mode();
//print_mode();

/*intersection() {
  translate([20,-160,0]) cube([40,300,6]);
  translate([0,0,-7]) back();
}

intersection() {
  *#translate([-80,55,0]) cube([200,40,6]);
  translate([0,0,-7]) back();
}*/
