class CommentsController < ApplicationController
	before_action :find_params, only: [:create, :destroy, :edit, :update]
	before_action :comment_params, only: [:create, :update]
	def create
		@comment = @post.comments.build(comment_params)
		@comment.user_id = current_user.id if current_user
		if @comment.save
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end
	def edit
		@comment = @post.comments.find(params[:id])
	end
	def update
		@comment = @post.comments.find(params[:id])
		if @comment.update(comment_params)
			redirect_to post_path(@post)
		else
			render 'edit'
		end
	end
	def destroy
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end
private
	def find_params
		@post = Post.find(params[:post_id])
	end
	def comment_params
		params.require(:comment).permit(:content)
	end
	
end

