# encoding: UTF-8

module PackageLib
  ROOT = 'public/packages/'
  BASE_URL = '/packages/'

    class Package
    attr_accessor :path
    attr_accessor :ipa

    def initialize(path)
      @path = path
    end
    
    def relative_path
      @path[ROOT.length+1..-1]
    end

    def plist_exists?
      ! @path.nil? and File.exist? @path + '.plist'
    end

    def yml_exists?
      ! @path.nil? and File.exist? @path + '.yml'
    end

    def create_plist(env)
      path = @path + '.plist'
      if self.ipa
        data = {
          'path' => 'packages/' + self.relative_path,
          'name' => self.ipa.name,
          'id' => self.ipa.bundle_identifier,
          'icon' => '',
        }
        controller = ActionController::Base.new
        plist = controller.render_to_string "packages/manifest.xml.erb", :layout => false, :locals => {:ipa => data, :env => env}
        #Rails.logger.info plist
        begin
          File.write(path, plist)
        rescue => err
          Rails.logger.error err
        end
      end
    end

    def create_yml
      path = @path + '.yml'
      if self.ipa
        data = {
          'version' => self.ipa.version,
          'name' => self.ipa.name,
          'id' => self.ipa.bundle_identifier,
          'minimum_os_version' => self.ipa.minimum_os_version,
        }
        data.each { |k, v| data[k] = v.force_encoding "UTF-8" }
        begin 
          File.write(path, data.to_yaml)
       rescue => err  
         Rails.logger.error err  
       end  
      end
    end

    def ipa
      if @ipa.nil?
        path = File.absolute_path @path

        if File.exist? path
          require 'rubygems'
          require Rails.root.join('lib', 'ipa_reader', 'lib', 'ipa_reader')
          @ipa = IpaReader::IpaFile.new(path)
        end
      end
      @ipa
    end
  end

end
