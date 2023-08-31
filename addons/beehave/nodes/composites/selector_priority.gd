## Selector Priority nodes will first sort its children based on their priority.
## It will then act as a Selector and attempt to execute each of its children
## until one of them return `SUCCESS`. If all children return `FAILURE`,
## this node will also return `FAILURE`.
## If a child returns `RUNNING` it will tick again.
@tool
@icon("../../icons/selector.svg")
class_name SelectorPriorityComposite extends SelectorComposite


func tick(actor: Node, blackboard: Blackboard) -> int:
	var children: Array[Node] = get_children()
	var priority: Dictionary = {}

	# Map each child to their priority.
	# This is done so that get_priority is only called once per frame.
	for c in children:
		priority[c] = c.get_priority()

	# Sorts the children by their priority.
	children.sort_custom(func (a, b): return priority[a] < priority[b])

	for c in children:
		move_child(c, -1)

	return super(actor, blackboard)


func get_class_name() -> Array[StringName]:
	var classes := super()
	classes.push_back(&"SelectorPriorityComposite")
	return classes
