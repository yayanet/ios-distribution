module PackagesHelper

  ROOT_PATH = 'public/packages/'

  def relative_path(path)
    path[ROOT_PATH.length+1..-1]
  end

end
