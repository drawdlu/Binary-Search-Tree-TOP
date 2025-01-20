# frozen_string_literal: true

module BinarySearchTree
  # A node on the tree
  class Node
    include Comparable

    attr_accessor :data, :left, :right

    def initialize(data)
      @data = data
      @left = nil
      @right = nil
    end

    def precedence
      @data
    end

    def <=>(other)
      precedence <=> other.precedence
    end
  end
end
