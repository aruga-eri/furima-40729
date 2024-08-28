class CreateLoads < ActiveRecord::Migration[7.0]
  def change
    create_table :loads do |t|

      t.timestamps
    end
  end
end
