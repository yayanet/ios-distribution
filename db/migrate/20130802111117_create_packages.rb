class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :path
      t.string :bundle_id
      t.string :name

      t.timestamps
    end

    add_index :packages, :path
  end
end
