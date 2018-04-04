class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.integer :competition_id
      t.integer :user_id
      t.string :comment
      t.string :point
      t.string :file
      t.timestamps
    end
  end
end
