class AddAuthorToPosts < ActiveRecord::Migration[8.0]
  def up
    unless column_exists?(:posts, :author_id)
      add_reference :posts, :author, foreign_key: { to_table: :users }
    end

    default_user_id = User.first&.id || 1
    change_column_default :posts, :author_id, default_user_id
    Post.reset_column_information
    Post.where(author_id: nil).update_all(author_id: default_user_id)
    change_column_null :posts, :author_id, false
  end

  def down
    remove_reference :posts, :author, foreign_key: { to_table: :users }
  end
end
