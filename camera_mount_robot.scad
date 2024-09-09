// Parameters
// all dimensions in mm
bar_width_quick_grip = 10;   // Width of the bar (adjust to your bar size)
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
camera_screw_height = 10;  // Height of the camera screw block
camera_screw_depth = 5; // Depth of the camera screw block
camera_screw_width = 50;  // Width of the camera screw block
camera_screw_width_rotation = 10;


// 5.   New parameters for screw holes
intel_realsense_screw_hole_diameter = 2.5;  // Diameter of the screw holes
intel_realsense_screw_hole_spacing = 45;    // Spacing between the two screw holes

// 6. New parameters for screw holes




// Attachment block
module attachment(screw_rotation) {
    difference() {
        union() {
            // 1. Attachment-block
            cube([attachment_block_length, attachment_block_width, attachment_block_thickness]);
            
            // 2. Mid-block
            translate([attachment_block_length/2 - mid_block_width/2, attachment_block_width/2 - mid_block_width/2, attachment_block_thickness])
                cube([mid_block_width, mid_block_width, mid_block_height]);
            
            // 3. Camera attachment
            translate([attachment_block_length/2 - mid_block_width/2, attachment_block_width/2 - camera_attachment_width/2, attachment_block_thickness + mid_block_height])
                cube([mid_block_width + camera_attachment_height, camera_attachment_width, camera_attachment_depth]);
            
            // 4. Camera screw block (attached to bottom face of camera attachment, at top of x-axis)
            translate([attachment_block_length/2 - mid_block_width/2 + mid_block_width + camera_attachment_height - camera_screw_height,
                       attachment_block_width/2 - camera_screw_width/2,
                       attachment_block_thickness + mid_block_height - camera_screw_depth + 3])
                rotate([0, screw_rotation, 0])  // Use the parameter for rotation
                cube([camera_screw_height, camera_screw_width, camera_screw_depth]);
        }

        // Subtract a hole for the bar to fit in the attachment-block
        translate([-0.1, (attachment_block_width - bar_width_quick_grip) / 2, -0.1])
            cube([attachment_block_length + 0.2, bar_width_quick_grip, bar_thickness_quick_grip + 0.1]);

        // Subtract the screw hole in the attachment-block
        translate([screw_offset_from_edge, attachment_block_width / 2, -0.1])
            cylinder(h = attachment_block_thickness + 0.2, d = screw_hole_diameter, $fn=32);

        // Add two screw holes for Intel RealSense camera
        translate([attachment_block_length/2 - mid_block_width/2 + mid_block_width + camera_attachment_height - camera_screw_height/2,
                   attachment_block_width/2 - intel_realsense_screw_hole_spacing/2,
                   attachment_block_thickness + mid_block_height - camera_screw_depth - 0.1])
            cylinder(h = camera_screw_depth + 0.2, d = intel_realsense_screw_hole_diameter, $fn=32);

        // Second screw hole for Intel RealSense camera
        translate([attachment_block_length/2 - mid_block_width/2 + mid_block_width + camera_attachment_height - camera_screw_height/2,
                   attachment_block_width/2 + intel_realsense_screw_hole_spacing/2,
                   attachment_block_thickness + mid_block_height - camera_screw_depth - 0.1])
            cylinder(h = camera_screw_depth + 0.2, d = intel_realsense_screw_hole_diameter, $fn=32);
    }
}

// Render three attachments with different rotations and positions
translate([0, 0, 0]) attachment(10);
translate([0, attachment_block_width + 40, 0]) attachment(20);
translate([0, (attachment_block_width + 40) * 2, 0]) attachment(30);
