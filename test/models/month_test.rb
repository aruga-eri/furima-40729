class Month < ActiveHash::Base
  self.data = (1..12).map.with_index(1) do |month, index|
    { id: index, name: month.to_s }
  end
end
