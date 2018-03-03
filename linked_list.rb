class LinkedList
  attr_reader :first, :size

  include Enumerable

  def initialize
    @first = nil
    @size = 0
  end

  def index_of(elem)
    index = find_index { |node| node.value == elem }
    index.nil? ? -1 : index
  end

  def add(index = nil, elem)
    raise IndexError if index && (index < 0 || index >= @size)
    if @first.nil?
      @first = Node.new(elem, nil)
    elsif @first.next_elem.nil?
      @first.next_elem = Node.new(elem, nil)
    else
      if index
        node_at_index = get_element_or_value(index, value: false)
        prev_node = get_element_or_value(index - 1, value: false)
        prev_node.next_elem = Node.new(elem, node_at_index)
      else
        last_node = get_element_or_value(@size - 1, value: false)
        last_node.next_elem = Node.new(elem, nil)
      end
    end
    @size += 1
    self
  end

  alias << add

  def set(index, elem)
    node = get_element_or_value(index, value: false)
    node.value = elem
  end

  def remove(index)
    node = get_element_or_value(index, value: false)
    node_prev = get_element_or_value(index - 1, value: false)
    node_prev.next_elem = node.next_elem
    @size -= 1
    node
  end

  def get(index)
    get_element_or_value(index)
  end

  def add_all(index = nil, collection)
    raise IndexError if index && (index < 0 || index >= @size)
    if @first.nil?
      @first = collection.first
    elsif @first.next_elem.nil?
      @first.next_elem = collection.first
    else
      if index
        node_at_index = get_element_or_value(index, value: false)
        prev_node = get_element_or_value(index - 1, value: false)
        prev_node.next_elem = collection.first
        collection_last = collection.send(:get_element_or_value, collection.size - 1, value: false)
        collection_last.next_elem = node_at_index
      else
        last_node = get_element_or_value(@size - 1, value: false)
        last_node.next_elem = collection.first
      end
    end
    @size += collection.size
  end

  def each(&block)
    return to_enum(:each) unless block_given?
    elem = @first
    while elem != nil
      yield elem
      elem = elem.next_elem
    end
  end

  def to_a
    map{|node| node.value }
  end

  class Node
    attr_accessor :value, :next_elem

    def initialize(value, next_elem)
      @value = value
      @next_elem = next_elem
    end
  end

  private
    def get_element_or_value(index, value: true)
      raise IndexError if index < 0 || index >= @size
      node_at_index = find.with_index { |node, node_index| node if node_index == index }
      value ? node_at_index.value : node_at_index
    end

end