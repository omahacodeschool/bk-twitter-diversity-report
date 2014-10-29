class Array
  def count_list_members
    counting_hash = {}
    self.each do |c|
      if counting_hash.has_key?(c)
        counting_hash[c] += 1
      else
        counting_hash[c] = 1
      end
    end
    counting_hash
  end
end