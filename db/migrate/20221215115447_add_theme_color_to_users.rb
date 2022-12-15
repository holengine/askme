class AddThemeColorToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :theme_color, :string, default: '#370617'
  end
end
