class CommentsController < ApplicationController
  # before_action :authorize, only: [:create, :edit, :update, :destroy]
  # before_action :authorize, only: [:create, :destroy]
  # before_action :set_comment, only: [:show, :edit, :update, :destroy]
  # before_action :set_comment, only: [:destroy]
  before_action :require_login, only: [ :create, :destroy ]
  before_action :set_post, only: [ :create, :destroy ]
  before_action :set_comment, only: [ :destroy ]
  before_action :check_comment_owner, only: [ :destroy ]

  def create
    # @comment = @post.comments.new(comment_params.merge(author_id: current_user))
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      render "posts/show"
    end
  end

  # def create
  #  @post = Post.find(params[:post_id])
  #  @comment = @post.comments.create(comment_params)
  #  redirect_to post_path(@post)
  # end

  # def create
  #  @post = current_user.posts.new(post_params) # Связываем пост с текущим пользователем
  #
  #  if @post.save
  #    redirect_to @post, notice: 'Post was successfully created.'
  #  else
  #    render :new, status: :unprocessable_entity
  #  end
  # end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: "Comment was successfully deleted.", status: :see_other
  end

  # def destroy
  #  @comment.destroy
  #  redirect_to @post, notice: 'Comment was successfully deleted.', status: :see_other
  # end

  # def destroy
  #  @post = Post.find(params[:post_id])
  #  @comment = @post.comments.find(params[:id])
  #  @comment.destroy
  #  redirect_to post_path(@post), status: :see_other
  # end

  private
    # def comment_params
    #  params.require(:comment).permit(:commenter, :body, :status)
    # end

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = @post.comments.find(params[:id])
    end

    def check_comment_owner
      unless @comment.author == current_user
        redirect_to @post, alert: "You can only delete your own comments."
      end
    end

    def comment_params
      params.require(:comment).permit(:body, :status)
    end
end
