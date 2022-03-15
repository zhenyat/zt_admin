################################################################################
#   command_parser.rb
#     Command line options analysis on a base of Ruby OptionParser class
#
#     ref: http://ruby-doc.org/stdlib-2.2.0/libdoc/optparse/rdoc/OptionParser.html#top
#
#   16.01.2017  ZT
#   26.12.2020  New options
#   13.11.2021  uuid option
#   12.12.2021  database option
################################################################################
require 'optparse'
require 'optparse/time'
require 'ostruct'

module ZtAdmin
  class OptparseCommand

    # Returns a structure describing the Command options
    def self.parse(args)
      if args.size == 0
        puts ZtAdmin::colored RED, "Not enough arguments. To learn the command use options: -h or --help"
        exit
      end

      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      options = OpenStruct.new
      options.enum = []

      opt_parser = OptionParser.new do |opts|
        opts.banner  = "\nv.1 - for Rails 5 with Sprockets"
        opts.banner << "\nv.2 - for Rails 6 with Webpacker"
        opts.banner << "\nv.3 - API mode generation added"
        opts.banner << "\nCurrent version: #{VERSION}\n"
        opts.banner << "\nUsage:#{TAB*2}zt_admin {i | init}     - Gemfile to be updated for further `bundle install`"
        opts.banner << "\n#{TAB*5}zt_admin {c | clone}    - generic files to be added"
        opts.banner << "\n#{TAB*5}                          including:  MVC User; VC sessions; VC pages/home"
        opts.banner << "\n#{TAB*5}zt_admin {a | api}      - API generic files to be added"
        opts.banner << "\n#{TAB*5}zt_admin {g | generate} <model_name> [options]"
        opts.banner << "\n#{TAB*5}zt_admin {d | destroy}  <model_name>"
        opts.banner << "\n\nExamples: zt_admin i --uuid\n#{TAB*5}zt_admin i --database mysql\n#{TAB*5}zt_admin c -u\n#{TAB*5}zt_admin a\n#{TAB*5}zt_admin g Product -e category -d\n#{TAB*5}zt_admin destroy Product"
        opts.banner << "\n#{TAB*5}zt_admin g Category -e status -a -c -i -p\n#{TAB*5}zt_admin d Category"
        opts.separator ""
        opts.separator "Specific options:"

        # Mandatory argument.
        opts.on("-e", "--enum ENUMERATED ATTRIBUTE",
                "Requires the Model enum attribute for input field in a view form") do |enum|
          options.enum << enum
        end

        opts.on("-a", "--ancestry", "Sets permitted attribute 'ancestry'") do
          $ancestry = true
        end

        opts.on("-c", "--content", "Sets permitted ActiveText 'content' attribute") do
          $content = true
        end

        opts.on("-i", "--images", "Sets permitted ActiveStorage images attributes") do
          $images = true
        end

        opts.on("-p", "--position", "Sets 'position' attribute handling") do
          $position = true
        end

        opts.separator ""
        opts.separator "Init / Clone options:"

        opts.on("-u", "--uuid", "Applies UUID (universally unique IDentifier) to 'Entity ID'") do
          $uuid   = true
          $dbname = 'postgresql'
        end

        opts.on("--database name", "Select a database: #{DATABASES_LIST}") do |dbname|
          $dbname = dbname
        end

        opts.separator ""
        opts.separator "Common options:"

        # Debug flag: no arguments
        opts.on("-d", "--debug", "Debug printing is ON") do
          $debug = true
        end

        # No argument, shows at tail.  This will print an options summary.
        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        # Another typical switch to print the version.
        opts.on("-v", "--version", "Show version\n") do
          puts VERSION
          exit
        end

        # Batch procedures
        opts.separator ""
        opts.separator "Batch procedures:"
        opts.separator "#{TAB*2}zt_batch.sh #{TAB*4}Applies gem 'zt_admin' to an App\n"
        opts.separator "#{TAB*2}zt_update.sh#{TAB*4}Updates gem 'zt_admin' according to the last code change\n"
      end

      opt_parser.parse!(args)
      options
    end           # parse()
  end             # class OptparseCommand
end