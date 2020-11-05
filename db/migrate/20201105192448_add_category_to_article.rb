class AddCategoryToArticle < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :category, null: false, foreign_key: true
  end
end
