require_relative 'node'

class Tree
  attr_accessor :root
  def initialize(array = [])
    @root = build_tree(clean(array))
  end

  # Private method
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

  def insert(node = root, data)
    if node.nil?
      Node.new(data)
    else
      if node.data == data
        node
      elsif node.data < data
        node.right = insert(node.right,data)
      else
        node.left = insert(node.left, data)
      end
      node
    end
  end

  def delete(node = root, data)
    return node if node.nil?

    if node.data > data
      node.left = delete(node.left, data)
    elsif node.data < data
      node.right = delete(node.right, data)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      node.data = get(node.right).data
      node.right = delete(node.right,node.data)
    end
    node
  end

  #private method
  def get(node)
     current = node
     current = node.left until current.left.nil?
     current
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

test = Tree.new(array)

test.delete(8)

test.pretty_print