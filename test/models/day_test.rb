class Day < ActiveHash::Base
  self.data = (1..31).map.with_index(1) do |day, index|
    { id: index, name: day.to_s }
  end
end
