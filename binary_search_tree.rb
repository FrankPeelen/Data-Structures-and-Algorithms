class Node
	attr_accessor :value, :parent, :left_child, :right_child

	def initialize(value)
		@value = value
		@left_child
		@right_child
	end

	def to_s
		left_to_s = @left_child.to_s unless @left_child.nil?
		right_to_s = @right_child.to_s unless @right_child.nil?
		"#{@value}L:[#{left_to_s}]R:[#{right_to_s}] "
	end
end

# Require arr.size > 0
def build_tree_helper(arr)
	return Node.new(arr[0]) if arr.size == 1
	node = Node.new(arr.slice!(arr.size / 2))
	tree = build_tree(arr)
	until (node.value > tree.value && tree.right_child.nil?) || (node.value <= tree.value && tree.left_child.nil?)
		tree = node.value > tree.value ? tree.right_child : tree.left_child
	end
	if node.value > tree.value
		tree.right_child = node
		node.parent = tree
	else
		tree.left_child = node
		node.parent = tree
	end
end

def build_tree(arr)
	node = build_tree_helper(arr)
	until node.parent.nil?
		node = node.parent
	end
	node
end

def breadth_first_search(root, target)
	queue = [root]
	while queue.size > 0
		if !queue.first.left_child.nil? && queue.first.left_child.value == target
			return queue.first.left_child
		elsif !queue.first.left_child.nil?
			queue.push(queue.first.left_child)
		end
		if !queue.first.right_child.nil? && queue.first.right_child.value == target
			return queue.first.right_child
		elsif !queue.first.right_child.nil?
			queue.push(queue.first.right_child)
		end
		queue.delete_at(0)
	end
	return nil
end

def depth_first_search(root, target)
	stack = [root]
	counted = []
	while stack.size > 0
		if !stack.last.left_child.nil? && stack.last.left_child.value == target
			return stack.last.left_child
		elsif !stack.last.left_child.nil? && !counted.include?(stack.last.left_child)
			stack.push(stack.last.left_child)
		elsif !stack.last.right_child.nil? && stack.last.right_child.value == target
			return stack.last.right_child
		elsif !stack.last.right_child.nil? && !counted.include?(stack.last.right_child)
			stack.push(stack.last.right_child)
		else
			counted.push(stack.last)
			stack.delete_at(-1)
		end
	end
	return nil
end

def dfs_rec(node, target)
	return node if node.value == target
	return dfs_rec(node.left_child, target) unless node.left_child.nil? || dfs_rec(node.left_child, target).nil?
	return dfs_rec(node.right_child, target) unless node.right_child.nil? || dfs_rec(node.right_child, target).nil?
	return nil
end

#puts [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324].sort.to_s
#puts build_tree([3, 1, 7]).to_s
puts dfs_rec(build_tree([1, 3, 5, 7, 8, 9, 14, 23, 35, 47, 59, 67, 6345, 324]), 6345).value.to_s