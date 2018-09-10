require 'thor'
require 'gocd_xml_to_groovy'
require 'gocd_xml_to_groovy/to_groovy'
require 'json'

module GocdXmlToGroovy
  class CLI < Thor
    desc "process FILE_OR_DIR", "Converts JSON file contents (from GoCD API) to groovy DSL"
    method_option :split, type: :boolean, default: true, desc: 'Split each pipeline in a separate file'
    method_option :output_dir, required: true, type: :string, desc: 'The output dir for groovy DSL files'
    def process(file_or_dir)
      if File.directory?(file_or_dir)
        Dir["#{file_or_dir}/*.json"].each do |each_file|
          process(each_file)
        end
      else
        puts "Processing #{file_or_dir}"
        output_file = File.join(options[:output_dir], File.basename(file_or_dir)).gsub(/\.json$/, '.gocd.groovy')
        GocdXmlToGroovy::ToGroovy.new(JSON.parse(File.read(file_or_dir)), options.merge(output_file: output_file)).process
      end
    end

    desc "version", "Prints the version"
    def version
      puts "GoCD XML To Groovy DSL version #{GocdXmlToGroovy::VERSION}"
      exit
    end
  end
end
