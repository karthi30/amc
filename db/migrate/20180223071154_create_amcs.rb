class CreateAmcs < ActiveRecord::Migration[5.1]
  def change
    create_table :amcs do |t|
  		t.string :scheme_code
  		t.string :scheme_name
  		t.string :net_asset_value
  		t.string :repurchase_price
  		t.string :sale_price
  		t.string :on_date
  		t.timestamps null: false
  	end
  end
end
