
module slide_top_box(
  // parameterized box with sliding dovetail top
  // v1.1.0
  size=[80, 110, 30], // x (width), y (length), z (height)
  thickness=4, // walls and lid
  lid_inset=0, // distance from top of box to top of lid (0 for flush)
  has_finger_recess=true, // optional finger grip indent
  is_interior_size=false, // when true, size defines interior volume, walls extend beyond
) {

  module box(size, thickness) {
    difference () {
      cube(size=[size.x, size.y, size.z], center=false);
      translate([thickness, thickness, thickness])
        cube(size=[size.x-thickness*2, size.y-thickness*2, size.z-thickness*1], center=false);
    };
  }

  module lid(size, ridge, recess=undef) {
    t  = size.z;
    hx = size.x / 2;
    hy = size.y / 2;

    translate([hx, hy, 0])
    difference() {
      // lid plate: trapezoid prism
      polyhedron(
        points = [
          // top points, clockwise starting at max x, max y
          [  hx - t,    hy,      t], // 0
          [  hx - t,  -(hy - t), t], // 1
          [-(hx - t), -(hy - t), t], // 2
          [-(hx - t),   hy,      t], // 3

          // bottom points (with ridge), clockwise starting at max x, max y
          [  hx - t+ridge,    hy,            0], // 4
          [  hx - t+ridge,  -(hy - t+ridge), 0], // 5
          [-(hx - t+ridge), -(hy - t+ridge), 0], // 6
          [-(hx - t+ridge),   hy,            0], // 7
        ],
        faces = [
          [0, 1, 2, 3], // top face
          [0, 4, 5, 1], // left slope
          [1, 5, 6, 2], // back slope
          [3, 2, 6, 7], // right slope
          [0, 3, 7, 4], // front face
          [7, 6, 5, 4], // bottom face
        ]
      );
      // lid recess: triangle prism
      if (recess != undef) {
        lrx = recess.x;
        lry = recess.y;
        lrz = recess.z;
        leading_edge = min(hy-lry-t*2, hy*.8-lry);
        translate([-lrx/2, leading_edge, t])
          polyhedron(
            points=[ [0,0,0], [lrx,0,0], [lrx,lry,-lrz], [0,lry,-lrz], [0,lry,0], [lrx,lry,0] ],
            faces=[ [0,1,2,3], [5,4,3,2], [0,4,5,1], [0,3,4], [5,2,1] ]
          );
      }
    };
  }

  box_size = is_interior_size ? size + [thickness*2, thickness*2, thickness*2] : size;
  lid_size = [box_size.x, box_size.y, thickness];
  lid_groove = thickness / 3; // how deep into the box wall should the lid groove cut
  lid_recess = has_finger_recess ? [box_size.x / 3, box_size.y / 4, thickness / 2] : undef; // use undef for none

  // box
  difference () {
    box(size=box_size, thickness=thickness);
    // subtract lid to create sliding groove
    translate([0, 0, box_size.z - lid_inset - lid_size.z])
      lid(size=lid_size, ridge=lid_groove);
  }

  // lid, next to box
  translate([box_size.x, 0, 0])
    lid(size=lid_size, ridge=lid_groove, recess=lid_recess);

}

slide_top_box();
