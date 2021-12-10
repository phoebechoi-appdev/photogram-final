class PhotosController < ApplicationController

  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })
    
    @photos = Photo.joins(:poster).all.where({ :users => { :private => false } }).order({ :created_at => :desc })
    
    render({ :template => "photos/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => the_id })

    @photo = matching_photos.at(0)

    render({ :template => "photos/show.html.erb" })
  end

  def create
    @photo = Photo.new
    @photo.caption = params.fetch("query_caption")
    @photo.image = params.fetch("image")
    @photo.owner_id = @current_user.id

    if @photo.valid?
      @photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      redirect_to("/photos", { :notice => "Photo failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @photo = Photo.where({ :id => the_id }).at(0)

    @photo.caption = params.fetch("query_caption")
    @photo.image = params.fetch("image")

    if @photo.valid?
      @photo.save
      redirect_to("/photos/#{@photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{@photo.id}", { :alert => "Photo failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @photo = Photo.where({ :id => the_id }).at(0)

    @photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end
end
