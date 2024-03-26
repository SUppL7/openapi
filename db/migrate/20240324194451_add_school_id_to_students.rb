class AddSchoolIdToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :school_id, :bigint
    add_index :students, :school_id
  end
end
