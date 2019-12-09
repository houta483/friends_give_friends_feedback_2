class AddFeedbackCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :feedbacks_count, :integer
  end
end
