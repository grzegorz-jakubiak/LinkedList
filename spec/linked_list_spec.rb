require_relative '../linked_list'

describe LinkedList do

  context 'methods' do

    before(:each) do
      @list = LinkedList.new
    end

    context '#indexOf' do
      it 'returns -1 if not found' do
        @list << 5
        expect(@list.index_of(13)).to eq -1
      end

      it 'returns index' do
        @list << 5 << 4 << 7 << 9
        expect(@list.index_of(7)).to eq 2
      end

    end

    context '#add' do
      it 'raises IndexError' do
        expect { @list.add(3, 5) }.to raise_error IndexError
      end

      it 'adds one element' do
        @list.add 3
        expect(@list.size).to eq 1
      end

      it 'adds two elements' do
        @list << 3 << 5
        expect(@list.size).to eq 2
      end

      it 'adds at index' do
        @list << 3 << 6 << 6 << 7 << 8 << 43 << 78
        @list.add 2, 90
        expect(@list.to_a).to eq [3 , 6 , 90, 6 , 7 , 8 , 43 , 78]
      end

    end

    context '#add_all' do

      it 'raises IndexError' do
        expect{ @list.add_all(123, LinkedList.new << 6 << 7 << 8) }.to raise_error IndexError
      end

      it 'adds collection to empty list' do
        @list.add_all(LinkedList.new << 6 << 7 << 8)
        expect(@list.to_a).to eq [6, 7, 8]
      end

      it 'adds collection to list with one element' do
        @list << 3
        @list.add_all(LinkedList.new << 6 << 7 << 8)
        expect(@list.to_a).to eq [3, 6, 7, 8]
      end

      it 'adds collection to list with elements' do
        @list << 4 << 5 << 6
        @list.add_all(LinkedList.new << 6 << 7 << 8)
        expect(@list.to_a).to eq [4, 5, 6, 6, 7, 8]
      end

      it 'adds collection at index to list with elements' do
        @list << 4 << 5 << 6
        @list.add_all(2, LinkedList.new << 90 << 7 << 8)
        expect(@list.to_a).to eq [4, 5, 90, 7, 8, 6]
      end

    end

    context '#remove' do
      it 'raises IndexError' do
        expect{ @list.remove(0) }.to raise_error IndexError
      end

      it 'removes element' do
        @list << 5 << 6 << 7 << 8
        @list.remove(1)
        expect(@list.to_a).to eq [5, 7, 8]
        expect(@list.size).to eq 3
      end
    end

    context '#set' do
      it 'raises IndexError' do
        expect{@list.set(3, "a")}.to raise_error IndexError
      end

      it 'sets element at index' do
        @list << 5 << 6 << 7 << 8
        @list.set(2, 'a')
        expect(@list.get(2)).to eq 'a'
      end
    end

    context '#get' do

      it 'raises IndexError' do
        expect{ @list.get(2) }.to raise_error IndexError
      end

      it 'gets element at specific index' do
        @list << 4
        expect(@list.get(0)).to eq 4
      end
    end
  end
end