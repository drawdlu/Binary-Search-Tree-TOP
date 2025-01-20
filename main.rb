# frozen_string_literal: true

require_relative 'lib/tree'

test = BinarySearchTree::Tree.new([1, 2, 3, 4, 5, 5])

test.pretty_print

test.insert(-1)

test.pretty_print
