# **Knights Travails**

## Assignment

Your task is to build a function knight_moves that shows the shortest possible way to get from one square to another by outputting all squares the knight will stop on along the way.

You can think of the board as having 2-dimensional coordinates. Your function would therefore look like:

- knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
- knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
- knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]

## Architecture

- Board model – _:public_methods_; [:x_size, :y_size, :moves_path, :add_knight, :knight, :grid_array, :grid_position, :pull_first_value, :grid_array=, :create_grid, :coords_within_bounds?, :valid_knights_moves, :knight_moves, :check, :position_found?]

- Knight model – _:private_methods_; [:x, :y, :all_knights_moves]

- main.rb; contains the running script. However this was TDD written software, so just read and run the tests.

## Solutiuon approach

This code was written with TDD via RSpec.

Architecture was informed by the fact that I knew that my final project for The Odin Project's Ruby curriculum was building the game of Chess, i.e. I split classes out, wrote them in their own files, gave a board its own correctly dimensioned grid object (2D array) and the ability to store a knight (Board#add_knight) in correct location in its grid.

My approach was essentially to:
1. generate all possible knight's moves (Knight#all_knights_moves).
2. reject moves which were out of the chess board's bounds and add remaining valid moves, with knowledge of their parent, to a queue(Board#valid_knights_moves).
3. check queue for presence of end_value (Board#knight_moves & #check), if found count and return move parent hierarchy to start coordinate, if not found return to step 1.

## Comments, limitations and refactoring thouhgts

Using TDD I built method by method. On reaching the stage of storing the valid moves in a queue and considering the need to store a move's parental hierarchy I chose to simply store the move and its parent's coordinate as 2 arrays nested inside another array, e.g. [[4,5], [3,3]]. Though a simple concept it results in undesirably deeply nested array data structure. On further consideration creation of a tree, with upto x8 children per node, with each node holding a parent variable, would be a neater data construct.

In the current implementation every single move coordinate in the queue array needs to be checked on each iteration of viable next moves, and all moves get checked over again on the next iteration. To improve performance a move could have a @checked boolean to save repeated checking. If a tree were used as the moves data structure then breadth first search could be limited to only the newly generated moves/node layer so to save the effort of searching higher levels of already generated and already checked moves/nodes.

Currently a board is only able to store one knight, and has no concept of other pieces, color of squares.