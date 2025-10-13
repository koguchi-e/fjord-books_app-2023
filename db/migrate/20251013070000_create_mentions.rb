class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      t.string :mentionable

      t.timestamps
    end
  end
end
