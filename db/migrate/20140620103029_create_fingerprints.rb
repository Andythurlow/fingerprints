class CreateFingerprint < ActiveRecord::Migration
  def change
    create_table :fingerprints do |t|
      t.string :name
      t.string :img_src

      t.timestamps
    end

    add_index :fingerprints, :name
  end
end
