
//units: mm

//main body block
z = 13.35;
x = 6.5;
y = 5;

$fs=.1;
//wire holes
start_height = 1.6;
height_increment = 1.33;
collumn_gap = 3;
tol = 1; //tolerance for ensuring complete cuts (no zero width sections)
collumn_x = 1.57;
wire_diameter = 0.36;
module CenterBlock(N_wirepairs){
  difference(){
    cube([x,y, start_height + height_increment*(N_wirepairs + .6)]);
    // first collumn
    for (i = [0:N_wirepairs]){
      translate([collumn_x, -tol/2, start_height + i*height_increment]) {
	rotate(90,[-1,0,0]) {
	  cylinder(r=wire_diameter/2, y + tol);
	}
	//second collumn
	translate([collumn_gap, 0, 0]){
	  rotate(90,[-1,0,0]) {
	    cylinder(r=wire_diameter/2, y + tol);
	  }
	}
      }
    }
  }
}

module LScrewWing(){
  // screw wings
  translate([-4.75,0,0]){
    difference(){
      cube([4.75, 5, 4]);
      translate([2.3, 2.5, -tol/2]){
	cylinder(h=6+tol, r=1.14);
      }
    }
  }
}
module RScrewRing(){
  translate([6.5,0,0]){
    difference(){
      cube([4.75, 5, 4]);
      translate([4.75-2.3, 2.5, -tol/2]){
	cylinder(h=6+tol, r=1.14);
      }
    }
  }
}

//$fn=20;
//$fs=1;
union(){
    CenterBlock(12);
    LScrewWing();
    RScrewRing();
}
