require 'erb'
require 'hashie/mash'
require 'active_support'
require 'active_support/core_ext'
require 'tilt'
require 'fileutils'

module GocdXmlToGroovy
  class ToGroovy
    attr_reader :pipeline
    attr_reader :options

    def initialize(pipeline, options)
      pipeline = pipeline.dup
      pipeline.delete('_links')

      @pipeline = Hashie::Mash.new(pipeline)
      @options = options
    end

    def process
      template = Tilt::ErubisTemplate.new(File.join(File.dirname(__FILE__), 'templates/pipeline.groovy.erb'), trim: '-<>')
      FileUtils.mkdir_p(File.dirname(options[:output_file]))
      open(options[:output_file], 'w') do |out|
        out.puts(template.render(self))
      end
    end
    
    def filtered_attributes(thing, *args)
      special_keys = args.extract_options!
      special_keys.deep_stringify_keys!
      keys = args.collect(&:to_s)

      thing = thing.dup
      keys_to_ignore = [*special_keys.delete('_ignore')].compact.collect(&:to_s)

      thing.each do |k, v|
        next if keys_to_ignore.include?(k)
        new_key = keys.find {|each_key| each_key.underscore == k }
        new_key ||= special_keys[k]
        if new_key && !blank_like?(thing[k])
          yield new_key, coerce_value(thing[k]) 
        end
        raise "Found unknown key: #{k}" unless new_key
      end
    end

    def plain_variables(environment_variables)
      environment_variables.select {|ev| !ev.secure}
    end

    def longest_plain_var_name(environment_variables)
      plain_variables(environment_variables).collect(&:name).max_by(&:length).length
    end

    def secure_variables(environment_variables)
      environment_variables.select {|ev| ev.secure}
    end

    def longest_secure_var_name(environment_variables)
      secure_variables(environment_variables).collect(&:name).max_by(&:length).length
    end

    def blank_like?(object)
      object == nil || ((object.kind_of?(Array) || object.kind_of?(Hash)) && object.empty?)
    end

    def render(template, opts)
      Tilt.new(File.join(File.dirname(__FILE__), "templates/#{template}")).render(self, opts)
    end

    def coerce_value(value)
      case value
      when TrueClass, FalseClass
        value
      when String
        "'#{value}'"
      when Array
        "[#{value.collect {|v| coerce_value(v) }.join(', ')}]"
      else
        value
      end
    end
  end

end
