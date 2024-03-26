class AddNameToSchools < ActiveRecord::Migration[7.1]
  def change
    add_column :schools, :name, :string
  end
end
