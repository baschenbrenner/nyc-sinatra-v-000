class CreateFigureTitlesTable < ActiveRecord::Migration
  def change
    create_table :figure_titles, id: false do |t|
      t.integer :figure_id
      t.integer :title_id
    end
    add_index :figure_titles, :title_id
    add_index :figure_titles, :figure_id
  end
end
