# frozen_string_literal: true

require_relative 'lib/tree'

test = BinarySearchTree::Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 24, 25, 56])

test.pretty_print
puts test.balanced?
