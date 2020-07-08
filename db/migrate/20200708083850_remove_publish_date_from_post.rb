class RemovePublishDateFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :publish_date, :string
  end
end
