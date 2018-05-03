class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.string :name, :index => true
      t.string :description
    end
  end
end
