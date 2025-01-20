# frozen_string_literal: true

require_relative 'lib/tree'

test = BinarySearchTree::Tree.new([10, 20, 15, 5, 33, 2, 12, 19])

test.pretty_print
p test.level_order
