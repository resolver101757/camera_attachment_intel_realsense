// Parameters
// all dimensions in mm
bar_width_quick_grip = 15;   // Width of the bar (adjust to your bar size)
bar_thickness_quick_grip = 5;  // Thickness of the bar (adjust to your bar size)
screw_hole_diameter = 3;  // Diameter of the screw hole
screw_offset_from_edge = 5;  // Offset for the screw hole from the edge of the bar

// 1. Attachment-block parameters
attachment_block_length = 30;  // Length of the attachment block
attachment_block_width = 30;   // Width of the attachment block
attachment_block_thickness = 10;  // Thickness of the attachment block

// 2. Mid-block parameters
mid_block_height = 20;  // Height of the mid-block
mid_block_width = 15;   // Width of the mid-block

// 3. Camera attachment parameters
camera_attachment_width = mid_block_width;  // Width of the camera attachment block
camera_attachment_depth = 15; // Depth of the camera attachment block
camera_attachment_height = 50;  // Height of the camera attachment block

// 4. Camera screw block parameters
camera_screw_height = 5;  // Height of the camera screw block
camera_screw_depth = 50; // Depth of the camera screw block
camera_screw_width = 20;  // Width of the camera screw block
camera_screw_width_rotation = 10;


// 5.   New parameters for screw holes
intel_realsense_screw_hole_diameter = 2.5;  // Diameter of the screw holes
intel_realsense_screw_hole_spacing = 45;    // Spacing between the two screw holes





// Attachment block
module attachment(screw_rotation) {
    difference() {
        union() {
            // 1. Attachment-block with rounded edges
            color("red")
            rounded_cube([attachment_block_length, attachment_block_width, attachment_block_thickness], 2); // Radius of rounding
            
            // 2. Mid-block with rounded edges
            color("green")
            translate([attachment_block_length/2 - mid_block_width/2, attachment_block_width, 0])
                rounded_cube([mid_block_width, mid_block_height, attachment_block_thickness], 2);
            
            // 3. Camera attachment with rounded edges
            color("blue")
            translate([attachment_block_length/2 - mid_block_width/2, 
                       attachment_block_width + mid_block_height, 
                       attachment_block_thickness/2 - camera_attachment_width/2])
                rounded_cube([mid_block_width + camera_attachment_height, camera_attachment_depth, camera_attachment_width], 2);
            
            // 4. Camera screw block with rounded edges
            color("yellow")
            translate([attachment_block_length/2  + camera_attachment_height,
                       attachment_block_width + camera_screw_height/2,
                       -2])
                rotate([0, screw_rotation, 0])
                rounded_cube([camera_screw_width, camera_screw_depth, camera_screw_height], 2);
        }

        // Subtract a hole for the bar to fit in the attachment-block
        translate([-0.1, (attachment_block_width - bar_width_quick_grip) / 2, -0.1])
            cube([attachment_block_length + 0.2, bar_width_quick_grip, bar_thickness_quick_grip + 0.1]);

        // Subtract the screw hole in the attachment-block
        translate([screw_offset_from_edge, attachment_block_width / 2, -0.1])
            cylinder(h = attachment_block_thickness + 0.2, d = screw_hole_diameter, $fn=32);

        // Define position for Intel RealSense screw holes
        screw_hole_position_left = [
            mid_block_height + camera_attachment_height + 8,
            attachment_block_width + mid_block_width + attachment_block_width/2 - camera_attachment_height/2,
            attachment_block_thickness/2 - intel_realsense_screw_hole_spacing/2 
        ];

        // Define position for Intel RealSense screw holes
        screw_hole_position_right = [
            mid_block_height + camera_attachment_height + 8,
            attachment_block_width + mid_block_width + attachment_block_width/2 - camera_attachment_height/2 + intel_realsense_screw_hole_spacing,
            attachment_block_thickness/2 - intel_realsense_screw_hole_spacing/2 
        ];

        // Add two screw holes for Intel RealSense camera
        translate(screw_hole_position_left)
            rotate([0, 0, 0])
            cylinder(h = camera_attachment_depth + camera_screw_depth + 0.2, d = intel_realsense_screw_hole_diameter, $fn=32);

        // Second screw hole for Intel RealSense camera
        translate(screw_hole_position_right)
            rotate([0, 0, 0])
            cylinder(h = camera_attachment_depth + camera_screw_depth + 0.2, d = intel_realsense_screw_hole_diameter, $fn=32);
    }
}

// Function to create a rounded cube
module rounded_cube(size, radius) {
    hull() {
        for (x = [0, size[0]]) {
            for (y = [0, size[1]]) {
                for (z = [0, size[2]]) { // Added z-axis rounding
                    translate([x, y, z])
                        cylinder(r = radius, h = size[2], $fn=16);
                }
            }
        }
    }
}

// Render three attachments with different rotations and positions
translate([0, 0, 0]) attachment(10);
translate([0, attachment_block_width + 45, 0]) attachment(20);
translate([0, (attachment_block_width + 45) * 2, 0]) attachment(30);