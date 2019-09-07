class Image
  def initialize(matrix)
    @matrix = matrix
  end

  def row_change(distance, xy_loc)
    # if the location of the one is greater than or equal to 0
    # and less than the length of the the row continue on 
    # otherwise be done
    # puts xy_loc[1]
    if xy_loc[1] >= 0 && xy_loc[1] < @matrix[0].length
      # This will move the location of the method to change the rows above
      row_above = [xy_loc[0] - 1, xy_loc[1]]
      # This will move the location of the method to change the rows below
      row_below = [xy_loc[0] + 1, xy_loc[1]]
      
      # Initialize iterator
      i = 0
      while distance >= 0
        #Change moving left of 1
        if xy_loc[1] - i >= 0
          @matrix[xy_loc[0]][xy_loc[1] - i] = 1
        end
        #Change moving right of 1
        if xy_loc[1] + i < @matrix[0].length
          @matrix[xy_loc[0]][xy_loc[1] + i] = 1
        end
        # Reduce the distance by -1 for the row above and below
        distance -=1
        # if the movement up from the 1 position is >= 0
        if row_above[0] >= 0
          # Recursive method to change above rows
          row_change(distance, row_above)
        end
        # if the movement down from the 1 position is < matrix.length
        if row_below[0] < @matrix.length
          # Recursive method to change below rows
          row_change(distance, row_below)
        end
        i+=1

      end
    end
  end

  def column_change(distance)
    @one_loc.each do |xy|
      row_change(distance, xy)
    end
    print_matrix
  end

  def blur(distance)
    @one_loc = []
    @matrix.each_with_index do |row, r_index|
      row.each_with_index do |column, c_index|
        # if the value at this index is 1
        if column == 1
          xy_loc = [r_index, c_index]
          @one_loc.push(xy_loc)
        end
      end 
    end 
    column_change(distance)

 
  end
  def print_matrix
    @matrix.each do |row|
      puts row.join('')
    end
  end
end

image = Image.new([
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 1, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0]
])
image.blur(1)
