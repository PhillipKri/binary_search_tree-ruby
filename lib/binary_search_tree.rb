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

  def find(data, node = root)
    return nil if node.nil?

    if data < node.data
      find(data, node.left)
    elsif data > node.data
      find(data, node.right)
    else
      node
    end
  end

  # iterative level order
  # def level_order(node = root)
  #   return nil if node.nil?
  #   queue = Array.new
  #   queue << node
  #   level = Array.new

  #   until queue.empty?
  #     current = queue[0]
  #     puts current
  #     level << queue.shift.data
  #     puts level
  #     queue << current.left unless current.left.nil?
  #     queue << current.right unless current.right.nil?
  #   end
  #   level
  # end

  #Recursive level order
  def level_order(node = root)
    h = height(node)
    for a in 1.. h
      print_current(node,a)
    end
  end

  def height(node = root)
    return 0 if node.nil?

    hleft = height(node.left)
    hright = height(node.right)
    hleft > hright ? hleft + 1 : hright + 1 
  end

  def print_current(node = root, level)
    return nil if node.nil?

    if level == 1
      puts node.data
    elsif level > 1
      print_current(node.left, level - 1)
      print_current(node.right, level - 1)
    end

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

test.pretty_print

p test.level_order