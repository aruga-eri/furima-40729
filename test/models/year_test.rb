require 'test_helper'

class YearTest < ActiveSupport::TestCase
  self.data = (1930..2019).map.with_index(1) do |year, index|
    { id: index, name: year.to_s }
  end
end
