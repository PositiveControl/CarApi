class CreateMakes < ActiveRecord::Migration[5.0]
  def change
    create_table :makes do |t|
      t.string :brand
    end
  end
end
