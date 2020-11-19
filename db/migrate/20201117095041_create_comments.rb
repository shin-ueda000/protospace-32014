class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :text,   null: false
      t.references :user,    foreing_key: true
      t.references :prototype,   foreing_key: true
      t.timestamps
    end
  end
end
