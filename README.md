# Heart Rate Animation
Recreation of the WatchOS heart rate animation from scratch using SwiftUI.
### It's all in the details:
- The center heart not just scales up and down, it wiggles like an actual heart.
- There's a glow on the leading and trailing edge of the primary heart and the glow flashes when the heart beats.
- There's a inner shadow in the shape of a compressed heart giving the primary one a 3d illusion effect.
- The heart pulses coming out doesn't just scale up and fade, they expand in it's path and becomes a cirlce.

### Things I couldn't recreate from the actual animation:
- The beating speed of the heart depends on the actual heart rate of the user in the app. Here it's a constant 1 second interval beating.

### Tools and Frameworks used:
- SwiftUI
- TimelineView
- Canvas
- Custom Shapes by drawing paths
- Animatable Data
- Custom Animations

### Breakdown
<div align="center">
  <video src="https://github.com/user-attachments/assets/7161c453-3ba7-437d-ae04-96e7dc7d6a14" width="400" />
</div>

### Demo
<div align="center">
  <video src="https://github.com/user-attachments/assets/2fd5f6b8-304b-43c2-a2a2-13289f718051" width="400" />
</div>




