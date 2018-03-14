class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.datetime :timestamp
      t.references :device, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
