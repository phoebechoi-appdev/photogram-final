class LikesController < ApplicationController
  def index
    matching_likes = Like.all

    @list_of_likes = matching_likes.order({ :created_at => :desc })

    @likes = Like.all.order({ :created_at => :desc })
    render({ :template => "likes/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_likes = Like.where({ :id => the_id })

    @like = matching_likes.at(0)

    render({ :template => "likes/show.html.erb" })
  end

  def create
    @like = Like.new
    @like.photo_id = params.fetch("query_photo_id")
    @like.fan_id = @current_user.id

    if @like.valid?
      @like.save
      redirect_to("/photos/#{@like.photo_id}", { :notice => "Like created successfully." })
    else
      redirect_to("/photos/#{@like.photo_id}", { :notice => "Like failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @like = Like.where({ :id => the_id }).at(0)

    @like.photo_id = params.fetch("query_photo_id")
    @like.fan_id = params.fetch("query_fan_id")

    if @like.valid?
      @like.save
      redirect_to("/likes/#{@like.id}", { :notice => "Like updated successfully."} )
    else
      redirect_to("/likes/#{@like.id}", { :alert => "Like failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @like = Like.where({ :id => the_id }).at(0)

    @like.destroy

    redirect_to("/photos/#{@like.photo_id}", { :notice => "Like deleted successfully."} )
  end
end
