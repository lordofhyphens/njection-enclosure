
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
  rotate([90,0,0])cylinder(r=4,h=w);
}
difference() {
  box(board_w,board_l, true);
  color("blue")translate([0,(hole_corner+10+board_l)/2,connector_height]) microusb();
  color("blue")translate([(board_w/2) - (1.04*25.4),-(hole_corner+board_l)/2,connector_height]) sma();
  color("blue")translate([-(board_w/2) + (1.04*25.4),-(hole_corner+board_l)/2,connector_height]) sma();
}
//cube([board_w,board_l,3]);
for (i = [-1,1]) {
  for (j = [1,-1]) {
    translate([mounthole + i*board_w/2, mounthole+j*board_l/2, 0]) difference() {
      cylinder(r=mounthole+2, h=standoff_height);
      cylinder(r=mounthole, h=standoff_height);
    }
  }
}
translate([150,0,0]) boxtop(board_w,board_l);
