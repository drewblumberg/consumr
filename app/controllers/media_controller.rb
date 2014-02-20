class MediaController < ApplicationController
  def new
    @media = Media.new
  end
end