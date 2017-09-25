class AddUserAndStatusToArticle < ActiveRecord::Migration[5.1]
  def change
    add_reference :articles, :user, foreign_key: true
    add_column :articles, :status, :string
  end
end
