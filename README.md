# Camera Mount for Robot

This OpenSCAD script generates a 3D-printable camera mount designed to attach an Intel RealSense camera to a robot using a quick-grip bar.

## Features

- Customizable attachment block for various bar sizes
- Adjustable mid-block and camera attachment dimensions
- Screw holes for securing the mount and camera

## Usage

1. Open the `camera_mount_robot.scad` file in OpenSCAD.
2. Adjust the parameters at the top of the file to fit your specific needs:
   - Bar dimensions
   - Attachment block size
   - Mid-block and camera attachment dimensions
   - Screw hole sizes and positions
3. Render the model and export it for 3D printing.

## Parameters

Key parameters include:

- `bar_width_quick_grip`: Width of the quick-grip bar
- `bar_thickness_quick_grip`: Thickness of the quick-grip bar
- `attachment_block_*`: Dimensions of the main attachment block
- `mid_block_*`: Dimensions of the middle block
- `camera_attachment_*`: Dimensions of the camera attachment section
- `intel_realsense_screw_hole_*`: Specifications for the camera screw holes

## Customization

Modify the parameters to adapt the mount for different camera models or mounting requirements.

## License

[Specify your chosen license here]
