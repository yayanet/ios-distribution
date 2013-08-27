module PackagesHelper

  ROOT_PATH = 'public/packages/'

  def relative_path(path)
    path[ROOT_PATH.length+1..-1]
  end

  class Package
    attr_accessor :path
    attr_accessor :ipa

    def initialize(path)
      @path = path
    end

    def plist_exists?
      if ! @path.nil? and File.exist? @path + '.plist'
        true
      else
        false
      end
    end

    def json_exists?
      if ! @path.nil? and File.exist? @path + '.json'
        true
      else
        false
      end
    end

    def create_plist
      path = @path + '.plist'
      if self.ipa
      end
    end

    def create_json
      path = @path + '.json'
      load_package
    end

    def ipa
      if @ipa.nil?
        path = File.absolute_path @path

        if File.exist? path
          require 'rubygems'
          require Rails.root.join('lib', 'ipa_reader', 'lib', 'ipa_reader')
          self.ipa = IpaReader::IpaFile.new(path)
        end
      end

      @ipa
    end

  end

end
