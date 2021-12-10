class UsersController < ApplicationController

  def index
    @users = User.all.order({ :username => :asc })
    render({ :template => "users/index.html" })
  end

  def show
    the_username = params.fetch("path_username")
    @user = User.where({ :username => the_username }).at(0)
    render({ :template => "users/show.html.erb" })
  end

  def liked_photos
    the_username = params.fetch("path_username")
    @user = User.where({ :username => the_username }).at(0)
    render({ :template => "users/liked_photos.html.erb" })
  end

  def feed
    the_username = params.fetch("path_username")
    @user = User.where({ :username => the_username }).at(0)
    render({ :template => "users/feed.html.erb" })
  end

  def discover
    the_username = params.fetch("path_username")
    @user = User.where({ :username => the_username }).at(0)
    render({ :template => "users/discover.html.erb" })
  end
end