class RenameDateOfBirthToBirthDate < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :date_of_birth, :birth_date
  end
end
