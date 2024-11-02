require_relative 'node'

class Tree
  attr_accessor :root
  def initialize(array = [])
    @root = build_tree(clean(array))
  end

  def clean(array)
    array.sort.uniq
  end

  def build_tree(arr, start_a = 0, end_a = arr.length - 1)
    return nil if start_a > end_a

    middle = (start_a + end_a) / 2
    
    root = Node.new(arr[middle])

    root.left = build_tree(arr, start_a, middle - 1)
    root.right = build_tree(arr, middle + 1, end_a)
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

test = Tree.new(array)

test.pretty_print