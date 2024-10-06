class CreateExperiences < ActiveRecord::Migration[7.2]
  def change
    create_table :experiences do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :company_name
      t.string :location
      t.date :start_date
      t.date :end_date
      t.boolean :current
      t.text :description

      t.timestamps
    end
  end
end
