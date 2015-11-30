class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :status

      t.timestamps null: false
    end
  end
end
