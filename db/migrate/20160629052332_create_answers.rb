class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :meaning
      t.integer :status
      t.references :word, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
