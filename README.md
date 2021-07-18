# slide_top_box
openscad module for a sliding dovetail lidded box

![sliding dovetail lidded box][thumbnail]

## usage

```scad
use <slide_top_box.scad>

slide_top_box(
  size=[80, 110, 30], // x (width), y (length), z (height)
  thickness=4, // walls and lid
  lid_inset=0, // how far from the top of the box should the top of the lid be (0 for flush)
  has_finger_recess=true // optional finger grip indent
)
```

### parameters

- **size** - an x,y,z vector defining the outer dimensions of the box
- **thickness** - thickness of the walls and lid (reduces interior volume)
- **lid_inset** - distance from top of box to top of lid; `0` for flush
- **has_finger_recess** - `true` to add finger grip on lid, `false` for none

## installation

- ensure `OPENSCADPATH` is set (see [docs][openscadpath], requires restarting OpenSCAD)
- save [`slide_top_box.scad`][slide_top_box] to a directory in the path
- add `use <slide_top_box.scad>` to your scad file



[openscadpath]: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries#Library_Locations "OpenSCAD User Manual / Libraries"
[slide_top_box]: ./slide_top_box.scad "slide top box scad module"
[thumbnail]: ./slide_top_box-defaults.png "rendering of the slide top box with default parameter values"
