use <../Meta/Debug.scad>;
use <../Meta/Manifold.scad>;
use <../Meta/Units.scad>;
use <../Vitamins/Nuts And Bolts.scad>;
use <../Vitamins/Pipe.scad>;
use <Set Screw.scad>;

module PrintableShaftCollar(pipeSpec=Spec_TubingOnePointOneTwoFive(),
                            pipeClearance=PipeClearanceLoose(),
                            length=UnitsMetric(10), height=UnitsMetric(12),
                            wall=UnitsMetric(5),
                            setScrewSpec=Spec_BoltM4(), setScrewLength=UnitsMetric(8),
                            screwOffsetZ=UnitsMetric(6),
                            teardropAngle=90, cutter=false) {

  render()
  rotate(-90)
  difference() {

    // Holder Block
    union() {
      difference() {
        hull() {

          cylinder(r=PipeOuterRadius(pipeSpec)+wall,
                 h=height,
               $fn=PipeFn(pipeSpec)*2);

          SetScrewSupport(radius=PipeOuterRadius(pipeSpec, PipeClearanceLoose()),
                          length=length, height=height, wall=wall,
                          boltSpec=setScrewSpec);
        }

        if (cutter==false)
        Pipe(pipe=pipeSpec,
           length=height*3,
        clearance=pipeClearance,
           center=true);
      }
    }

    if (cutter==false)
    translate([0,0,screwOffsetZ])
    SetScrew(boltSpec=Spec_BoltM4(),
             radius=PipeOuterRadius(pipeSpec),
             length=setScrewLength, capHeightExtra=wall,
             teardrop=true, teardropAngle=teardropAngle,
             clearance=true);
  }
}


scale(25.4)
PrintableShaftCollar(pipeSpec=Spec_TubingZeroPointSevenFive());
