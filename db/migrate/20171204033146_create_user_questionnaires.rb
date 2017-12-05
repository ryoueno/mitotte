class CreateUserQuestionnaires < ActiveRecord::Migration[5.0]
  def change
    create_table :user_questionnaires do |t|
      t.references :user, index: true, foreign_key: true
      t.references :questionnaire, index: true, foreign_key: true
      t.text :answer
    end
  end
end
