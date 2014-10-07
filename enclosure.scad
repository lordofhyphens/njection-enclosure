
board_w=3*25.4;
board_l=5.208*25.4;
hole_corner=.25*25.4;
mounthole=(.125 * 25.4 / 2);
standoff_height=.5*25.4;
board_height=.08*25.4;
connector_height = standoff_height + board_height;
module box(board_w, board_l, bottom=false) {
  traup = (bottom == false ? -(30+6)/2 : (30+6)/2);
  translate([0,0,(30+6)/2])
    difference() {
      difference() {
        cube([board_w+hole_corner+10,board_l+hole_corner+10,30+6], center=true);
        cube([board_w+hole_corner+6,board_l+hole_corner+6,30+2], center=true);
      }
      color("red")translate([0,0,traup])cube([board_w+hole_corner+10, board_l+hole_corner+10, (30+6)/2], center=true);
    }
  // standoffs
  for (i = [-1,1]) {
    for (j = [1,-1]) {
      color("blue") translate([i*-1*(board_w/2) + i*hole_corner, j*-1*(board_l/2)+j*hole_corner, 0])
        difference() {
          translate([(mounthole)/2,(mounthole)/2,0]) cylinder(r=mounthole+2, h=standoff_height);
          translate([(mounthole)/2,(mounthole)/2,0])
            cylinder(r=mounthole, h=standoff_height,$fn=50);
        }
    }
  }
}

module board() {
  // placeholder board
  difference() {
    translate([0,0,standoff_height+1.5])cube([board_w,board_l,board_height], center=true);
    for (i = [-1,1]) {
      for (j = [1,-1]) {
        translate([i*-1*(board_w/2) + i*hole_corner, j*-1*(board_l/2)+j*hole_corner, 0])
          translate([mounthole/2,mounthole*2,0])cylinder(r=mounthole, h=40,$fn=40);
      }
    }
  }
}
module boxtop(board_w, board_l, bottom=false) {
  cube([board_w+hole_corner+10,board_l+hole_corner+10,4], center=true);
  translate([0,0,+3])
  difference() {
    cube([board_w+hole_corner+6,board_l+hole_corner+6,2], center=true);
    cube([board_w+hole_corner+3,board_l+hole_corner+3,2], center=true);
  }

}
module microusb() {
  translate([0,0,3/2])cube([7,9,3], center=true);
}
module sma(w=9) {
  rotate([90,0,0])translate([0,3,0])cylinder(r=4,h=w);
}

// punching the cutouts in the box
// everything is in mm.
difference() {
  box(board_w,board_l, true);
  color("blue")translate([0,(hole_corner+10+board_l)/2,connector_height]) microusb();
  // change the +0 below to shift the connector holes up in mm.
  color("blue")translate([(board_w/2) - (1.04*25.4),-(hole_corner+board_l)/2,connector_height+0]) sma();
  color("blue")translate([-(board_w/2) + (1.04*25.4),-(hole_corner+board_l)/2,connector_height+0]) sma();
}


translate([150,0,0]) boxtop(board_w,board_l);
