class CreatePositiveWords < ActiveRecord::Migration[5.0]
  def change
    create_table :positive_words do |t|
      t.string :display
    end
  end
end
