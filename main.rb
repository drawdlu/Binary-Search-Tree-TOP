# frozen_string_literal: true

require_relative 'lib/tree'

test = BinarySearchTree::Tree.new(Array.new(15) { rand(1..100) })

test.pretty_print

puts test.balanced?
puts

# print out all node values
puts 'Level Order Traversal'
test.level_order { |val| print "#{val}, " }
puts
puts

puts 'Preorder Traversal'
test.preorder { |val| print "#{val}, " }
puts
puts

puts 'Postorder Traversal'
test.postorder { |val| print "#{val}, " }
puts
puts

puts 'Inorder Traversal'
test.inorder { |val| print "#{val}, " }
puts
puts

# unbalance the binary tree
test.insert(105)
test.insert(106)
test.insert(160)
test.insert(170)
test.insert(200)

test.pretty_print

puts test.balanced?
puts

# rebalance the tree
test.rebalance

test.pretty_print

puts test.balanced?
puts

# print out all node values again
puts 'Level Order Traversal'
test.level_order { |val| print "#{val}, " }
puts
puts

puts 'Preorder Traversal'
test.preorder { |val| print "#{val}, " }
puts
puts

puts 'Postorder Traversal'
test.postorder { |val| print "#{val}, " }
puts
puts

puts 'Inorder Traversal'
test.inorder { |val| print "#{val}, " }
puts
puts
