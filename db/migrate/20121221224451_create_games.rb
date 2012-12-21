class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :away
      t.float :away_predictor
      t.string :home
      t.float :home_predictor
      t.float :home_edge
      t.float :projected_spread
      t.float :spread_wagerline
      t.float :diff

      t.timestamps
    end
  end
end
