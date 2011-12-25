class CreateIdentities < ActiveRecord::Migration
  def up
    create_table :identities do |t|
      t.belongs_to :user
      t.references :api, :polymorphic => true

      t.string :unique_id, :null => false
      t.string :provider, :null => false
      t.text :auth_hash
      t.timestamps
    end

    add_index :identities, :user_id
    add_index :identities, [:api_id, :api_type]
    add_index :identities, [:user_id, :provider], :unique => true
    add_index :identities, [:provider, :unique_id], :unique => true
  end

  def down
    remove_index :identites, :user_id
    remove_index :identites, [:api_id, :api_type]
    remove_index :identites, [:user_id, :provider_id]
    remove_index :identites, [:provider, :unique_id]
    drop_table :identities
  end
end
