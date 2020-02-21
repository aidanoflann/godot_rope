extends Node2D

export var num_segments: int = 10
export var enabled: bool = true
var segments: Array = []
var string_node_scene: PackedScene = load("res://RopeNode.tscn")
var rope_joint_scene: PackedScene = load("res://RopeJoint.tscn")
onready var player_1: RigidBody2D = $"/root/Main/Player"
onready var player_2: RigidBody2D = $"/root/Main/Player2"
onready var start_position: Vector2 = player_1.transform.get_origin()
onready var end_position: Vector2 = player_2.transform.get_origin()

func _ready():
	if not self.enabled:
		return
	# we need to generate num_segments segments and num_segments + 1 node
	for i in range(self.num_segments):
		var rope_segment_instance: RigidBody2D
		var position: Vector2
		if i == 0:
			position = self.player_1.transform.get_origin()
		elif i == self.num_segments -1:
			position = self.player_2.transform.get_origin()
		else:
			var relative_distance: float = float(i)/float(self.num_segments)
			position = self.start_position + relative_distance * (self.end_position - self.start_position)
		rope_segment_instance = self.string_node_scene.instance()
		rope_segment_instance.transform.origin = position
		self.add_child(rope_segment_instance)
		segments.append(rope_segment_instance)
		
		if i > 0:
			# for any segments beyond the first, attach the previous two
			self._attach_nodes_at_position(-2, -1)
	
	# rope has been built, attach the players
	segments.push_front(self.player_1)
	segments.push_back(self.player_2)
	self._attach_nodes_at_position(0, 1)
	self._attach_nodes_at_position(-2, -1)

func _attach_nodes_at_position(position_a: int, position_b: int):
	var rope_joint_instance: PinJoint2D = self.rope_joint_scene.instance()
	self.add_child(rope_joint_instance)
	rope_joint_instance.transform.origin = (segments[position_b].transform.origin + segments[position_a].transform.origin) * 0.5
	rope_joint_instance.node_a = segments[position_a].get_path()
	rope_joint_instance.node_b = segments[position_b].get_path()

func _process(delta):
	# trigger redraw
	self.update()

func _draw():
	for i in range(len(self.segments) - 1):
		draw_line(
			self.segments[i].transform.origin,
			self.segments[i+1].transform.origin,
			Color(0/255.0, 0/255.0, 0/255.0),
			8
		)
		draw_line(
			self.segments[i].transform.origin,
			self.segments[i+1].transform.origin,
			Color(200/255.0, 200/255.0, 200/255.0),
			4
		)
