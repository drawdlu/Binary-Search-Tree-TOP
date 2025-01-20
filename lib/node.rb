# frozen_string_literal: true

module BinarySearchTree
  # A node on the tree
  class Node
    include comparable

    def initialize(data)
      @data = data
      @left_child = nil
      @right_child = nil
    end

    def precedence
      @data
    end

    def <=>(other)
      precedence <=> other.precedence
    end
  end
end
