class AddMakeIdToModels < ActiveRecord::Migration[5.0]
  def change
    change_table :models do |t|
      t.belongs_to :make, :index => true
    end
  end
end
