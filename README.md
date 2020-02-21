# godot_rope
Simple implementation of a rope in Godot using PinJoint2Ds and RigidBody2Ds.

The Rope node in the main scene has a script attached which will generate a series of RigidBody2Ds connected by PinJoints.
It also requires that the scene contains a Rigidbody2D called Player and another RigidBody2D called Player2. These two players
will be attached at either end of the rope. In this test case I've set one Player's weight to maximum value and disabled gravity
for it so that the other Player will swing from it, to demonstrate the effect.

Please feel free to copy/paste and reuse any of this you like. It's just here to demonstrate one way of doing a rope in Godot.
