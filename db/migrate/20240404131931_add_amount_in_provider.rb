class AddAmountInProvider < ActiveRecord::Migration[7.1]
  def change
    change_table :providers do |t|
      t.monetize :amount
    end
  end
end
