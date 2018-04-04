class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.integer :competition_id
      t.integer :user_id
      t.string :comment
      t.string :point
      t.string :file
      t.timestamps
    end
  end
end
