class PackagesController < ApplicationController

  def index
  end

  def list 
    require 'packagelib'

    path = PackageLib::ROOT
    path += '/' + params[:path] if params[:path]
    @files = Dir.glob(path + '/*')
    @ipas = Dir.glob(path + '/*.ipa')

    @ipas.each do |f|
      p = PackageLib::Package.new(f)
      p.create_yml if ! p.yml_exists?
      p.create_plist(self.env) if ! p.plist_exists?
    end
  end

end
