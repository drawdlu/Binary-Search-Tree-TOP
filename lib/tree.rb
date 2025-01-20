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

    def delete(value)
      curr_node = @root
      node_to_delete, parent_node, direction = find_node(curr_node, value)
      left_node = node_to_delete.left
      right_node = node_to_delete.right

      loop do
        if left_node.nil? && right_node.nil?
          parent_node.send("#{direction}=", nil)
          break
        elsif !left_node.nil? && !right_node.nil?
          successor = find_successor(node_to_delete)
          previous_node = node_to_delete
          node_to_delete, parent_node, direction = find_node(curr_node, successor.data)
          swap_values(successor, previous_node)
          left_node = node_to_delete.left
          right_node = node_to_delete.right
        else
          node_swap_direction = left_node.nil? ? :right : :left
          parent_node.send("#{direction}=", node_to_delete.send(node_swap_direction))
          node_to_delete.send("#{node_swap_direction}=", nil)
          break
        end
      end
    end

    def find_successor(node)
      successor = node.right
      successor = successor.left until successor.nil? || successor.left.nil?

      successor
    end

    def swap_values(node1, node2)
      temp = node1.data
      node1.data = node2.data
      node2.data = temp
    end

    def find_node(node, value)
      until node.data == value
        parent_node = node
        if node.data < value
          node = node.right
          direction = :right
        else
          node = node.left
          direction = :left
        end
      end

      [node, parent_node, direction]
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
  end
end
