class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.text :title
      t.text :body
      t.integer "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
