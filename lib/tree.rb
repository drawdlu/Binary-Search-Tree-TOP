# frozen_string_literal: true

require_relative 'node'

module BinarySearchTree
  # Binary Tree
  class Tree
    def initialize(arr)
      list = arr.sort.uniq
      @root = build_tree(list, 0, list.length - 1)
    end

    def build_tree(list, start, last)
      return nil if start > last

      mid = start + (last - start) / 2

      root = Node.new(list[mid])

      root.left = build_tree(list, start, mid - 1)

      root.right = build_tree(list, mid + 1, last)

      root
    end

    def insert(value, node = @root)
      if node.data < value
        if node.right.nil?
          node.right = Node.new(value)
        else
          insert(value, node.right)
        end
      elsif node.left.nil?
        node.left = Node.new(value)
      else
        insert(value, node.left)
      end
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
  end
end
