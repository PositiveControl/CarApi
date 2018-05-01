class CreateVehiclesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.string :utility_class
    end
  end
end
