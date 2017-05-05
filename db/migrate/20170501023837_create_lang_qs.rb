class CreateLangQs < ActiveRecord::Migration[5.0]
  def change
    create_table :lang_qs do |t|
      t.belongs_to :lang, foreign_key: true
      t.belongs_to :employee, foreign_key: true
      t.integer :level

      t.timestamps
    end
  end
end
