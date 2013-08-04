class PackagesController < ApplicationController
  include PackagesHelper

  def index
  end

  def list 
    path = ROOT_PATH
    path += '/' + params[:path] if params[:path]
    @files = Dir.glob(path + '/*')
  end
end
