
// updated code-------------------------------------------------
/*

Replica knob design for PiDP-11
(c) Ilkka Kallio

This work is based on measurements from a design by Christopher Byrd at
https://github.com/cbyrd01/3d-knob-for-pidp11.

This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 United States License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/us/ or send a
letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

  2020 June 14
  Modified by L.P Glaister VE7IT to include D shaft.
  Knob can be scaled without affecting shaft dimensions.

*/
KnobScale = 0.85; // Knob body. Scale to whatever size looks best to you
                  // use > 0.75 as shaft needs to fit inside knob body

KnobDiameter=19.5;
KnobHeight=17;
TopWidth=8.75;
TopLength=18;
TopRounding=4;
NotchWidth=1;
NotchDepth=1.5;

ShaftD = 6.35;
ShaftH = (KnobHeight - 2) * KnobScale;

$fn=90;
module knob()
{
  /* Knob body. Scale to whatever size looks best to you */
  scale(KnobScale)
  difference()
  {
    union()
    {

      /* Base shape is just a simple cylinder, 1mm tall */
      cylinder(r=KnobDiameter/2,h=1,center=true);

      /* Series of transitional cone shapes */
      translate([0,0,3+0.5]) cylinder(h=6,r1=KnobDiameter/2,r2=0.1, center = true);
      translate([0,0,4+0.5]) cylinder(h=8,r1=KnobDiameter/2-0.5,r2=0.1, center = true);
      translate([0,0,5+0.5]) cylinder(h=10,r1=KnobDiameter/2-1,r2=0.1, center = true);
      translate([0,0,6+0.5]) cylinder(h=12,r1=KnobDiameter/2-1.5,r2=0.1, center = true);
      translate([0,0,7+0.5]) cylinder(h=14,r1=KnobDiameter/2-2,r2=0.1, center = true);

      /* Handle / grip part */
      hull()
      {
        minkowski()
        {

cube([TopWidth+2-2*TopRounding,KnobDiameter-2*TopRounding,0.1], center=true);
          cylinder(r=TopRounding,h=0.1,center=true);
        }
        translate([0,0,KnobHeight]) minkowski()
        {
            cube([TopWidth-2*TopRounding,TopLength-2*TopRounding,0.1], center=true);
            cylinder(r=TopRounding,h=0.1,center=true);
        }
      }
    }

    /* Cut the notch to indicate which way knob is pointing */
    union()
    {
      rotate([-2.5,0,0]) translate([0,-(TopLength/2+.7),0]) cube([NotchWidth,NotchDepth,50], center=true);
      translate([0,0,KnobHeight]) union()
      {
        cylinder(r=1.25*NotchWidth, h=NotchDepth, center=true);
        translate([0,-TopLength/4,0]) cube([NotchWidth,TopLength/2,NotchDepth], center=true);
      }
    }
  }
}

module shaft()
{
  rotate([0,0,90]) difference()
  {
    translate([0,0,-10]) cylinder(d=ShaftD,h=ShaftH+10);
    translate([ShaftD/4,-ShaftD,0])cube([ShaftD*2,ShaftD*2,ShaftH*2]); // flatten shaft to form D shape
  }
}

difference()
{
  knob();
  shaft();
}
// end of updated code-------------------------------------------------
