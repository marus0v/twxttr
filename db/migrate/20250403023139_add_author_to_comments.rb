class AddAuthorToComments < ActiveRecord::Migration[8.0]
  def up
    unless column_exists?(:comments, :author_id)
      add_reference :comments, :author, foreign_key: { to_table: :users }
    end

    default_user_id = User.first&.id || 1
    change_column_default :comments, :author_id, default_user_id
    Comment.reset_column_information
    Comment.where(author_id: nil).update_all(author_id: default_user_id)
    change_column_null :comments, :author_id, false
  end

  def down
    remove_reference :comments, :author, foreign_key: { to_table: :users }
  end
end
