class CreateShortUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :short_urls do |t|
      t.string :short
      t.string :value

      t.timestamps
    end
  end
end
