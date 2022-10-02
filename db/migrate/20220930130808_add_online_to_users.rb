class AddOnlineToUsers < ActiveRecord::Migration[5.1]
    def change
      change_table :users do |t|
        t.boolean :online, default: false,  null: false
      end   
    end
end
