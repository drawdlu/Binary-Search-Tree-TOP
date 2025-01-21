# frozen_string_literal: true

require_relative 'node'

module BinarySearchTree
  # Binary Tree

  class Tree
    attr_reader :root

    def initialize(arr)
      list = arr.sort.uniq
      @root = build_tree(list, list.length - 1)
    end

    def build_tree(list, last, start = 0)
      return nil if start > last

      mid = start + (last - start) / 2

      root = Node.new(list[mid])

      root.left = build_tree(list, mid - 1, start)

      root.right = build_tree(list, last, mid + 1)

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

    def find(value)
      find_node(@root, value).nil? ? nil : find_node(@root, value)[0]
    end

    def level_order
      queue = [@root]
      values = []
      until queue.empty?
        curr_node = queue[0]
        queue.push(curr_node.left) unless curr_node.left.nil?
        queue.push(curr_node.right) unless curr_node.right.nil?

        if block_given?
          yield curr_node.data
        else
          values.push(curr_node.data)
        end

        queue.delete_at(0)
      end

      values unless block_given?
    end

    def inorder(node = @root, arr = [], &block)
      return if node.nil?

      inorder(node.left, arr, &block)

      if block_given?
        block.call(node.data)
      else
        arr.push(node.data)
      end

      inorder(node.right, arr, &block)

      arr
    end

    def preorder(node = @root, arr = [], &block)
      return if node.nil?

      if block_given?
        block.call(node.data)
      else
        arr.push(node.data)
      end

      preorder(node.left, arr, &block)
      preorder(node.right, arr, &block)

      arr
    end

    def postorder(node = @root, arr = [], &block)
      return if node.nil?

      postorder(node.left, arr, &block)
      postorder(node.right, arr, &block)

      if block_given?
        block.call(node.data)
      else
        arr.push(node.data)
      end

      arr
    end

    def depth(node)
      curr_node = @root
      depth_val = 0
      until curr_node == node || curr_node.nil?
        depth_val += 1

        curr_node = if curr_node.data < node.data
                      curr_node.right
                    else
                      curr_node.left
                    end
      end

      curr_node.nil? ? nil : depth_val
    end

    def height(node)
      queue = [node]
      height_val = 0

      until queue.empty?
        queue.length.times do
          curr_node = queue[0]
          queue.push(curr_node.left) unless curr_node.left.nil?
          queue.push(curr_node.right) unless curr_node.right.nil?
          queue.delete_at(0)
        end

        break if queue.empty?

        height_val += 1
      end

      height_val
    end

    def balanced?
      queue = [@root]

      until queue.empty?
        curr_node = queue[0]
        queue.push(curr_node.left) unless curr_node.left.nil?
        queue.push(curr_node.right) unless curr_node.right.nil?
        queue.delete_at(0)

        left_height = curr_node.left.nil? ? 0 : height(curr_node.left)
        right_height = curr_node.right.nil? ? 0 : height(curr_node.right)

        return false if (left_height - right_height).abs > 1
      end

      true
    end

    def rebalance
      node_arr = inorder
      @root = build_tree(node_arr, node_arr.length - 1)
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    private

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

        return nil if node.nil?
      end

      [node, parent_node, direction]
    end
  end
end
