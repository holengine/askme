class AddColumnToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :hidden, :boolean, default: false
    Question.where(hidden: nil).update_all(hidden: false)
  end
end
