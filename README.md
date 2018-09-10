# GoCD XML To Groovy DSL

This rubygem converts GoCD's XML configuration to a groovy DSL that is compatible with the [GoCD Groovy DSL configuration plugin](https://github.com/ketan/gocd-groovy-dsl-config-plugin).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gocd_xml_to_groovy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gocd_xml_to_groovy

## Usage

1. First clone this repository and setup dependencies

    ```shell
    git clone https://github.com/ketan/gocd_xml_to_groovy
    cd gocd_xml_to_groovy
    bin/setup
    ```

2. Download the pipeline config using API:
    
    ```shell
    curl https://build.gocd.org/go/api/admin/pipelines/name \
            -H 'Accept: application/vnd.go.cd.v6+json' \
            --output input-pipeline.json
    ```

3. Convert the pipeline config JSON to Groovy:

    ```shell
    bundle exec exe/gocd_xml_to_groovy process input-pipeline.json --output-dir OUTPUT_DIR
    ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ketan/gocd_xml_to_groovy.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
