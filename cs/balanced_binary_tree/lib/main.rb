require_relative 'node'
require_relative 'tree'

# In console run "ruby lib/main.rb" to see classes created and methods illustrated in console.
puts "\e[1m\e[34m1.\e[0m Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) })"
array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)
puts ''
puts "\e[1m\e[34m2.\e[0m Confirm that the tree is balanced by calling #balanced?"
puts "\t\e[32m#{tree.balanced?} \e[0m"
puts ''
puts "\e[1m\e[34m3.\e[0m Print out all elements in level, pre, post, and in order,"
puts "\there's breadth first level order traversal output:"
puts "\t\t\e[32m#{tree.level_order.inspect} \e[0m"
puts "\there's depth first pre-order traversal output:"
puts "\t\t\e[32m#{tree.pre_order.inspect} \e[0m"
puts "\there's depth first in-order traversal output:"
puts "\t\t\e[32m#{tree.in_order.inspect} \e[0m"
puts "\there's depth first post-order traversal output:"
puts "\t\t\e[32m#{tree.post_order.inspect} \e[0m"
puts ''
puts "\e[1m\e[34m4.\e[0m Unbalance the tree by adding several numbers > 100"
puts "#{%w(101 105 120).each { |n| tree.insert(n.to_i) }}"
puts "\t\t\e[32m#{tree.level_order.inspect} \e[0m"
tree.nice_print(tree.root)
puts ''
puts "\e[1m\e[34m5.\e[0m Confirm that the tree is balanced by calling #balanced?"
puts "\t\e[32mTree balanced, true or false; \e[31m#{tree.balanced?} \e[0m"
puts ''
puts "\e[1m\e[34m6.\e[0m Balance the tree by calling #rebalance"
puts "\t#{tree.rebalance}"
tree.nice_print(tree.root)
puts "\e[1m\e[34m7.\e[0m Confirm that the tree is balanced by calling #balanced?"
puts "\t\e[32mTree balanced, true or false; \e[31m#{tree.balanced?} \e[0m"
puts ''
puts "\e[1m\e[34m8.\e[0m Print out all elements in level, pre, post, and in order,"
puts "\there's breadth first level order traversal output:"
puts "\t\t\e[32m#{tree.level_order.inspect} \e[0m"
puts "\there's depth first pre-order traversal output:"
puts "\t\t\e[32m#{tree.pre_order.inspect} \e[0m"
puts "\there's depth first in-order traversal output:"
puts "\t\t\e[32m#{tree.in_order.inspect} \e[0m"
puts "\there's depth first post-order traversal output:"
puts "\t\t\e[32m#{tree.post_order.inspect} \e[0m"
