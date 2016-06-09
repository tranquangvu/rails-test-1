class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :vote_type
      t.references :joke, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
