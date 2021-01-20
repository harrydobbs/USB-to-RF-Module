$fn=100;

caseFasteningExternalRadius = 3; //M3 -
caseFasteningInternalRadius = 1.5-(0.25/2); //M3 -> enough for self tapping
caseFasteningInternaldepth = 12;

pcbX = 37.25 + caseFasteningExternalRadius/2;
pcbZ = 20.20 + caseFasteningExternalRadius/2;
pcbY = 20;

wallThickness = 5; // 2mm minimum is recommended
radius = 1.5;

pcbOffsetx = pcbX;
pcbOffsetz = 5;
pcbOffsety = 2;



//Floor plane...
translate([0,0,+wallThickness/2])
{
    minkowski()
    {

            cube([pcbX+(wallThickness*2)-radius,pcbZ+(wallThickness*2)-radius,wallThickness],center=true);
            cylinder(h=0.000000000000001,r=radius);
    }
}

translate([pcbX/2 + caseFasteningExternalRadius/2,pcbZ/2 + caseFasteningExternalRadius/2,pcbY/2 + wallThickness/2])
{
    cylinder(h=wallThickness, r=caseFasteningInternalRadius, center=true);
}
translate([pcbX/2 + caseFasteningExternalRadius/2,-(pcbZ/2 + caseFasteningExternalRadius/2),pcbY/2 + wallThickness/2])
{
    cylinder(h=wallThickness, r=caseFasteningInternalRadius, center=true);
}
translate([-(pcbX/2 + caseFasteningExternalRadius/2),-(pcbZ/2 + caseFasteningExternalRadius/2),pcbY/2 + wallThickness/2])
{
    cylinder(h=wallThickness, r=caseFasteningInternalRadius, center=true);
}
translate([-(pcbX/2 + caseFasteningExternalRadius/2),pcbZ/2 + caseFasteningExternalRadius/2,pcbY/2 + wallThickness / 2])
{
    cylinder(h=wallThickness, r=caseFasteningInternalRadius, center=true);
}







translate([80,0,0])
{

    // Sides....
    difference(){
       

        
        
        difference() {  
            
            translate([0,0,pcbY/2+wallThickness])
            {
                cube([pcbX+(wallThickness*2)-radius,pcbZ+(wallThickness*2)-radius,pcbY],center = true);

                minkowski()
                {

                        cube([pcbX+(wallThickness*2)-radius,pcbZ+(wallThickness*2)-radius,pcbY],center = true);
                        cylinder(h=0.000000000000001,r=radius);
                }
            }
         
            // Internal Cube 
            translate([0,0,pcbY/2+wallThickness])
            {
                minkowski()
                {
                  
                      cube([pcbX,pcbZ,pcbY+0.01], center = true);
                      cylinder(h=0.000000000000001,r=1);
                }
            }

        }
        
        union()
        {
            translate([pcbX/2 + caseFasteningExternalRadius/2,pcbZ/2 + caseFasteningExternalRadius/2,pcbY/2 + wallThickness])
            {
                
                cylinder(h=pcbY + 0.01, r=caseFasteningInternalRadius, center=true);
            }
            translate([pcbX/2 + caseFasteningExternalRadius/2,-(pcbZ/2 + caseFasteningExternalRadius/2),pcbY/2 + wallThickness])
            {
                
                cylinder(h=pcbY + 0.01, r=caseFasteningInternalRadius, center=true);
            }
            
            translate([-(pcbX/2 + caseFasteningExternalRadius/2),-(pcbZ/2 + caseFasteningExternalRadius/2),pcbY/2 + wallThickness])
            {
                
                cylinder(h=pcbY + 0.01, r=caseFasteningInternalRadius, center=true);
            }
                 translate([-(pcbX/2 + caseFasteningExternalRadius/2),(pcbZ/2 + caseFasteningExternalRadius/2),pcbY/2 + wallThickness])
            {
                
                cylinder(h=pcbY + 0.01, r=caseFasteningInternalRadius, center=true);
            }
            

        }

    }

    //Floor plane...
    translate([0,0,+wallThickness/2])
    {
        minkowski()
        {

                cube([pcbX+(wallThickness*2)-radius,pcbZ+(wallThickness*2)-radius,wallThickness],center=true);
                cylinder(h=0.000000000000001,r=radius);
        }
    }



    // PCB offsets
    translate([0,pcbZ/2-pcbOffsetz/2 + caseFasteningExternalRadius/2,pcbOffsety/2+wallThickness])
    {
        cube([pcbOffsetx,pcbOffsetz,pcbOffsety],center=true);
    }


    // PCB offsets
    translate([0,-pcbZ/2+pcbOffsetz/2 - caseFasteningExternalRadius/2,pcbOffsety/2+wallThickness])
    {
        cube([pcbOffsetx,pcbOffsetz,pcbOffsety],center=true);
    }



    translate([pcbX/2 + caseFasteningExternalRadius/2,pcbZ/2 + caseFasteningExternalRadius/2,pcbY/2 + wallThickness/2])
    {
        difference() {
            cylinder(h=pcbY + wallThickness - 0.01, r=caseFasteningExternalRadius, center=true);
            translate([0,0,pcbY/2+ caseFasteningInternaldepth/2]){
                cylinder(h=caseFasteningInternaldepth * 2, r=caseFasteningInternalRadius, center=true);
            }
        }

    }
    translate([pcbX/2 + caseFasteningExternalRadius/2,-(pcbZ/2 + caseFasteningExternalRadius/2),pcbY/2 + wallThickness/2])
    {
        difference() {
            cylinder(h=pcbY + wallThickness - 0.01, r=caseFasteningExternalRadius, center=true);
            translate([0,0,pcbY/2 + caseFasteningInternaldepth/2]){
                cylinder(h=caseFasteningInternaldepth * 2, r=caseFasteningInternalRadius, center=true);
            }
        }

    }
    translate([-(pcbX/2 + caseFasteningExternalRadius/2),-(pcbZ/2 + caseFasteningExternalRadius/2),pcbY/2 + wallThickness/2])
    {
        difference() {
            cylinder(h=pcbY + wallThickness - 0.01, r=caseFasteningExternalRadius, center=true);
            translate([0,0,pcbY/2 + caseFasteningInternaldepth/2]){
                cylinder(h=caseFasteningInternaldepth * 2, r=caseFasteningInternalRadius, center=true);
            }
        }

    }
    translate([-(pcbX/2 + caseFasteningExternalRadius/2),pcbZ/2 + caseFasteningExternalRadius/2,pcbY/2 + wallThickness / 2])
    {
        difference() {
            cylinder(h=pcbY + wallThickness - 0.01, r=caseFasteningExternalRadius, center=true);
            translate([0,0,pcbY/2 + caseFasteningInternaldepth/2]){
                cylinder(h=caseFasteningInternaldepth * 2, r=caseFasteningInternalRadius, center=true);
            }
        }
    }
}



