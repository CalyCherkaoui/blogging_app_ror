class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
      t.boolean :draft,  default: true
      t.boolean :published,  default: false
      t.datetime :published_at

      t.timestamps
    end
  end
end
