class CreateQuestionnaires < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaires do |t|
      t.text :display
      t.string :category
      t.json :options
    end
  end
end
