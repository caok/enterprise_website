class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :about
      t.text :culture
      t.string :contract
      t.string :mobile
      t.string :tel
      t.string :fax
      t.string :email
      t.string :qq
      t.string :links
      t.string :address

      t.timestamps
    end
  end
end
