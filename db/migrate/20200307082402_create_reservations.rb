class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
    	t.string :customer_name
    	t.integer :people
    	t.integer :reservation_time
      t.date :reservation_day
    	t.string :phone_number
    	t.string :email
    	t.text :request
      	t.timestamps
    end
  end
end
