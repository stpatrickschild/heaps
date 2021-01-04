require_relative "./min_heap"

# This method uses a heap to sort an array.
# Time Complexity:  O(long n)
# Space Complexity: O(n)
def heapsort(list)
  min_heap = MinHeap.new()
  list.each do |item|
    min_heap.add(item)
  end
  empty_arr = []

  list.length.times do
    empty_arr << min_heap.remove()
  end
  return empty_arr
end
