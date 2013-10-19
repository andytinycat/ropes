require 'debeasy'

module Ropes

  class Error < RuntimeError; end
  class InvalidRepositoryType < Error; end

  class Repository
    
    def initialize(options)
      missing_options = %w{
        origin 
        type 
        distribution 
        version 
        architecture 
        components 
        description}.reject do |required_option|
          options.has_key?(required_option)
      end

      raise "Missing options: #{missing_options.join(", ")}"

      raise InvalidRepositoryType, 
        "Repository type #{options[:type]} is neither :apt or :yum" unless options[:type] == :yum or type == :apt

      @options = options
      @packages = []
      @field_order = %w{
        package
        priority
        section
        installed_size
        maintainer
        architecture
        source
        version
        depends
        filename
        size
        MD5sum
        SHA1
        SHA256
        Description
        Description-md5
        Bugs
        Origin
        Supported
      }
      @mandatory_fields = %w{
        package
        version
        architecture
        maintainer
        description
      }
    end

    def add_file_by_path(path)
      metadata = Debeasy.read(path).to_hash
      if validate_metadata(metadata).empty?
        @packages << metadata
      else
        raise "Missing mandatory fields on package: #{validate_metadata(metadata).join(", ")}"
      end
    end

    def add_file_by_info(package)
      if validate_metadata(path).empty?
        if package.is_a? Hash
          @packages << package
        else
          raise "Package metadata must be in hash format"
        end
      else
        raise "Missing mandatory fields on package: #{validate_metadata(metadata).join(", ")}"
      end
    end

    def validate_metadata(metadata_hash)
      @mandatory_fields.reject {|field| metadata_hash.has_key?(field)}
    end

    def write_files(path)
      write_packages_gz("#{path}/Packages.gz")
    end

    def write_packages_gz(path)
      Zlib::GzipWriter.open(path) do |file|
        @packages.each do |package|
          @field_order.each do |field_order|
            file.puts "#{field_order.capitalize}: #{package[field_order]}"
          end
          file.puts
        end
      end
    end

  end
end
