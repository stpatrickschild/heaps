class HeapNode
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end

class MinHeap
  def initialize
    @store = []
  end

  # This method adds a HeapNode instance to the heap
  # Time Complexity: O (log n)
  # Space Complexity: O (n)
  def add(key, value = key)
    heap_node = HeapNode.new(key, value)
    @store.push(heap_node)
    curent_index = @store.length - 1
    parent_index = (curent_index - 1) / 2
    while heap_node.key < @store[parent_index].key
      swap(curent_index, parent_index)
      curent_index = parent_index
      parent_index = (curent_index - 1) / 2
      break if parent_index < 0
    end
  end

  # This method removes and returns an element from the heap
  #   maintaining the heap structure
  # Time Complexity: O (log n)
  # Space Complexity: O (n)
  def remove()
    return nil if @store.empty?
    swap(0, @store.length - 1)
    result = @store.pop
    curent_index = 0
    left_child_index = 1
    right_child_index = 2
    while @store[left_child_index] || @store[right_child_index]
      if @store[right_child_index] && @store[right_child_index].key < @store[left_child_index].key && @store[right_child_index].key < @store[curent_index].key
        swap(curent_index, right_child_index)
        curent_index = right_child_index
      elsif @store[right_child_index] && @store[right_child_index].key > @store[left_child_index].key && @store[left_child_index].key < @store[curent_index].key
        swap(curent_index, left_child_index)
        curent_index = left_child_index
      elsif @store[left_child_index] && @store[left_child_index].key < @store[curent_index].key
        swap(curent_index, left_child_index)
        curent_index = left_child_index
      else
        break
      end
      left_child_index = (curent_index * 2) + 1
      right_child_index = (curent_index * 2) + 2
    end
    return result.value
  end

  # Used for Testing
  def to_s
    return "[]" if @store.empty?

    output = "["
    (@store.length - 1).times do |index|
      output += @store[index].value + ", "
    end

    output += @store.last.value + "]"

    return output
  end

  # This method returns true if the heap is empty
  # Time complexity: O (1)
  # Space complexity: O (1)
  def empty?
    return @store.empty?
  end

  private

  # This helper method takes an index and
  #  moves it up the heap, if it is less than it's parent node.
  #  It could be **very** helpful for the add method.
  # Time complexity: ?
  # Space complexity: ?
  def heap_up(index)
    return nil if @store.empty?
    parent_index = (index - 1)/2
    if @store[index].key >= @store[parent_index].key || index == 0
      return @store
    else
      swap(index, parent_index)
      heap_up(parent_index)
    end
  end

  # This helper method takes an index and
  #  moves it up the heap if it's smaller
  #  than it's parent node.
  def heap_down(index)
    min = index
    left, right = 2 * index + 1, 2 * index + 2
    left < @store.length && @store[left].key < @store[min].key ? min = left : nil
    right < @store.length && @store[right].key < @store[min].key ? min = right : nil
    if min != index
      swap(index, min)
      heap_down(min)
    end
  end

  # If you want a swap method... you're welcome
  def swap(index_1, index_2)
    temp = @store[index_1]
    @store[index_1] = @store[index_2]
    @store[index_2] = temp
  end
end
