/*
  _   _  _    _              __                              
 |_) /  |_)  /   _.  _  _   /__  _  ._   _  ._ _. _|_  _  ._ 
 |   \_ |_)  \_ (_| _> (/_  \_| (/_ | | (/_ | (_|  |_ (_) |  
 
 Author: Harry Dobbs
 Description: A program used to generate 3D printable boxes for PCBs.
*/


//PARAMETERS
$fn=100;


CASE_FASTENER_BOSS_RADIUS = 6; 
CASE_FASTENER_INTERNAL_RADIUS = 3.3/2; // 3.3mm hole recommended
CASE_FASTENER_DEPTH = 12;

LID_FASTENER_RADIUS = 2.02; // 2mm and a bit of tolerance...

//PCB_X = 37.25 + CASE_FASTENER_BOSS_RADIUS/2;
//PCB_Z = 20.20 + CASE_FASTENER_BOSS_RADIUS/2;
//PCB_Y = 20;

PCB_X = 50 + CASE_FASTENER_BOSS_RADIUS/2;
PCB_Z = 75 + CASE_FASTENER_BOSS_RADIUS/2;
PCB_Y = 30;

WALL_THICKNESS = 5; // 2mm minimum is recommended
EDGE_RADIUS = 8;

STAND_OFF_X = PCB_X;
STAND_OFF_Z = 5;
STAND_OFF_Y = 0;

FASTENER_HEAD_RADIUS = 4;
FASTENER_HEAD_DEPTH = 2;
CASE_INSERT_DEPTH = 1.5;


module lid(){
    // Difference between a cube and the mounting holes...
    difference(){
        union(){
        translate([0,0,+WALL_THICKNESS/2]){
            minkowski(){
                    cube([PCB_X+(WALL_THICKNESS*2)-EDGE_RADIUS,PCB_Z+(WALL_THICKNESS*2)-EDGE_RADIUS,WALL_THICKNESS],center=true);            
                    cylinder(h=0.000000000000001,r=EDGE_RADIUS);
            }
            
        }
            translate([-(PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2),-(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),+WALL_THICKNESS/2])
    {
        difference() {
            cylinder(h=WALL_THICKNESS - 0.01, r=CASE_FASTENER_BOSS_RADIUS, center=true);
            cylinder(h=WALL_THICKNESS * 2, r=CASE_FASTENER_INTERNAL_RADIUS, center=true);
            
        }
    }
    translate([(PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2),-(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),+WALL_THICKNESS/2])
    {
        difference() {
            cylinder(h=WALL_THICKNESS - 0.01, r=CASE_FASTENER_BOSS_RADIUS, center=true);
            cylinder(h=WALL_THICKNESS * 2, r=CASE_FASTENER_INTERNAL_RADIUS, center=true);
            
        }

    }
    translate([(PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2),(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),+WALL_THICKNESS/2])
    {
        difference() {
            cylinder(h=WALL_THICKNESS - 0.01, r=CASE_FASTENER_BOSS_RADIUS, center=true);
            cylinder(h=WALL_THICKNESS * 2, r=CASE_FASTENER_INTERNAL_RADIUS, center=true);
            
        }

    }
    translate([-(PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2),(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),+WALL_THICKNESS/2])
    {
        difference() {
            cylinder(h=WALL_THICKNESS - 0.01, r=CASE_FASTENER_BOSS_RADIUS, center=true);
            cylinder(h=WALL_THICKNESS, r=CASE_FASTENER_INTERNAL_RADIUS, center=true);
            
        }
    }
        
    }

        union(){
            translate([PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2,PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2, WALL_THICKNESS/2]){
                cylinder(h=WALL_THICKNESS+0.1, r=LID_FASTENER_RADIUS, center=true);
                translate([0,0, 1.5]){
                    cylinder(h=FASTENER_HEAD_DEPTH, r=FASTENER_HEAD_RADIUS, center=true);
                }
            }
            translate([PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2,-(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),WALL_THICKNESS/2]){
                cylinder(h=WALL_THICKNESS+0.1, r=LID_FASTENER_RADIUS, center=true);
                translate([0,0, 1.5]){
                    cylinder(h=FASTENER_HEAD_DEPTH, r=FASTENER_HEAD_RADIUS, center=true);
                }
            }
            translate([-(PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2),-(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),WALL_THICKNESS/2]){
                cylinder(h=WALL_THICKNESS+0.1, r=LID_FASTENER_RADIUS, center=true);
                translate([0,0, 1.5]){
                    cylinder(h=FASTENER_HEAD_DEPTH, r=FASTENER_HEAD_RADIUS, center=true);
                }    
            }
            translate([-(PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2),PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2,WALL_THICKNESS / 2]){
                cylinder(h=WALL_THICKNESS+0.1, r=LID_FASTENER_RADIUS, center=true);
                translate([0,0, 1.5]){
                    cylinder(h=FASTENER_HEAD_DEPTH, r=FASTENER_HEAD_RADIUS, center=true);
                }    
            }
        }
    }
    
    difference(){
            translate([0,0,-CASE_INSERT_DEPTH/2]){

            cube([PCB_X,PCB_Z,CASE_INSERT_DEPTH-0.001],center=true); 
            }
            union(){
                translate([PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2,-(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),-CASE_INSERT_DEPTH/2]){
                    cylinder(h=CASE_INSERT_DEPTH+0.001, r=CASE_FASTENER_BOSS_RADIUS, center=true);
                    }
                translate([-(PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2),-(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),-CASE_INSERT_DEPTH/2]){
                    cylinder(h=CASE_INSERT_DEPTH+0.001, r=CASE_FASTENER_BOSS_RADIUS, center=true);
                    }

                translate([-(PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2),(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),-CASE_INSERT_DEPTH/2]){
                    cylinder(h=CASE_INSERT_DEPTH+0.001, r=CASE_FASTENER_BOSS_RADIUS, center=true);
                    }

                translate([PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2,(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),-CASE_INSERT_DEPTH/2]){
                    cylinder(h=CASE_INSERT_DEPTH+0.001, r=CASE_FASTENER_BOSS_RADIUS, center=true);
                    }
                }
    }
    

}

module box(){
    // Sides....
    difference(){
        difference() {
            // External Cube
            translate([0,0,PCB_Y/2+WALL_THICKNESS]){
                cube([PCB_X+(WALL_THICKNESS*2)-EDGE_RADIUS,PCB_Z+(WALL_THICKNESS*2)-EDGE_RADIUS,PCB_Y],center = true);
                minkowski()
                {
                        cube([PCB_X+(WALL_THICKNESS*2)-EDGE_RADIUS,PCB_Z+(WALL_THICKNESS*2)-EDGE_RADIUS,PCB_Y],center = true);
                        cylinder(h=0.000000000000001,r=EDGE_RADIUS);
                }
            }
         
            // Internal Cube 
            translate([0,0,PCB_Y/2+WALL_THICKNESS]){
                minkowski()
                {
                      cube([PCB_X,PCB_Z,PCB_Y+0.01], center = true);
                      cylinder(h=0.000000000000001,r=1);
                }
            }

        }
        
        union() {
            translate([PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2,PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2,PCB_Y/2 + WALL_THICKNESS])
            {
                
                cylinder(h=PCB_Y + 0.01, r=CASE_FASTENER_INTERNAL_RADIUS, center=true);
            }
            translate([PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2,-(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),PCB_Y/2 + WALL_THICKNESS])
            {
                
                cylinder(h=PCB_Y + 0.01, r=CASE_FASTENER_INTERNAL_RADIUS, center=true);
            }
            
            translate([-(PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2),-(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),PCB_Y/2 + WALL_THICKNESS])
            {
                
                cylinder(h=PCB_Y + 0.01, r=CASE_FASTENER_INTERNAL_RADIUS, center=true);
            }
                 translate([-(PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2),(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),PCB_Y/2 + WALL_THICKNESS])
            {
                
                cylinder(h=PCB_Y + 0.01, r=CASE_FASTENER_INTERNAL_RADIUS, center=true);
            }
        }

    }

    //Floor plane...
    translate([0,0,+WALL_THICKNESS/2])
    {
        minkowski()
        {

                cube([PCB_X+(WALL_THICKNESS*2)-EDGE_RADIUS,PCB_Z+(WALL_THICKNESS*2)-EDGE_RADIUS,WALL_THICKNESS],center=true);
                cylinder(h=0.000000000000001,r=EDGE_RADIUS);
        }
    }



    // PCB Stand offs
    translate([0,PCB_Z/2-STAND_OFF_Z/2 + CASE_FASTENER_BOSS_RADIUS/2,STAND_OFF_Y/2+WALL_THICKNESS])
    {
        cube([STAND_OFF_X + CASE_FASTENER_INTERNAL_RADIUS/2,STAND_OFF_Z,STAND_OFF_Y],center=true);
    }


    // PCB Stand offs
    translate([0,-PCB_Z/2+STAND_OFF_Z/2 - CASE_FASTENER_BOSS_RADIUS/2,STAND_OFF_Y/2+WALL_THICKNESS])
    {
        cube([STAND_OFF_X + CASE_FASTENER_INTERNAL_RADIUS/2,STAND_OFF_Z,STAND_OFF_Y],center=true);
    }



    translate([PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2,PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2,PCB_Y/2 + WALL_THICKNESS/2])
    {
        difference() {
            cylinder(h=PCB_Y + WALL_THICKNESS - 0.01, r=CASE_FASTENER_BOSS_RADIUS, center=true);
            translate([0,0,PCB_Y/2+ CASE_FASTENER_DEPTH/2]){
                cylinder(h=CASE_FASTENER_DEPTH * 2, r=CASE_FASTENER_INTERNAL_RADIUS, center=true);
            }
        }

    }
    translate([PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2,-(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),PCB_Y/2 + WALL_THICKNESS/2])
    {
        difference() {
            cylinder(h=PCB_Y + WALL_THICKNESS - 0.01, r=CASE_FASTENER_BOSS_RADIUS, center=true);
            translate([0,0,PCB_Y/2 + CASE_FASTENER_DEPTH/2]){
                cylinder(h=CASE_FASTENER_DEPTH * 2, r=CASE_FASTENER_INTERNAL_RADIUS, center=true);
            }
        }

    }
    translate([-(PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2),-(PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2),PCB_Y/2 + WALL_THICKNESS/2])
    {
        difference() {
            cylinder(h=PCB_Y + WALL_THICKNESS - 0.01, r=CASE_FASTENER_BOSS_RADIUS, center=true);
            translate([0,0,PCB_Y/2 + CASE_FASTENER_DEPTH/2]){
                cylinder(h=CASE_FASTENER_DEPTH * 2, r=CASE_FASTENER_INTERNAL_RADIUS, center=true);
            }
        }

    }
    translate([-(PCB_X/2 + CASE_FASTENER_BOSS_RADIUS/2),PCB_Z/2 + CASE_FASTENER_BOSS_RADIUS/2,PCB_Y/2 + WALL_THICKNESS / 2])
    {
        difference() {
            cylinder(h=PCB_Y + WALL_THICKNESS - 0.01, r=CASE_FASTENER_BOSS_RADIUS, center=true);
            translate([0,0,PCB_Y/2 + CASE_FASTENER_DEPTH/2]){
                cylinder(h=CASE_FASTENER_DEPTH * 2, r=CASE_FASTENER_INTERNAL_RADIUS, center=true);
            }
        }
    }
}




translate([PCB_X + WALL_THICKNESS + 20,0,WALL_THICKNESS])rotate([180,0,0]){{lid();}}
difference(){box();union(){
    
    
    rotate([0,90,90]){translate([-(WALL_THICKNESS+6),16.5,-30]){cylinder(h=50 + WALL_THICKNESS - 0.01, r=5.8, center=true);}}
    
    translate([11,-40,(15+ WALL_THICKNESS/2)]){cube([24,20,20],center=true);}

    
    
    
    }}
