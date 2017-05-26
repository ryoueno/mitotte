class AddExtensionToScreenshots < ActiveRecord::Migration[5.0]
  def change
    add_column :screenshots, :extension, :string, :null => false, :after => :src
  end
end
