################################################################################
#   setpar.rb
#     Initializes parameters for the gem
#
#   09.07.2020  ZT
#   17.10.2020  Last update (AppName definition)
#   12.12.2021  database option
#   10.01.2022  test
################################################################################

# Constants
BLACK   = 'black'
BLUE    = 'blue'
CYAN    = 'cyan'
GRAY    = 'grey'
GREY    = 'gray'
GREEN   = 'green'
MAGENTA = 'magenta'
RED     = 'red'
WHITE   = 'white'
YELLOW  = 'yellow'

TAB   = '  '        # Two spaces - to be used instead of \t

DATABASES_LIST = 'mysql, postgresql, sqlite (default)'

# Special attribute cases (identified in *get_attributes*)
$references_names   = []
$password_attribute = nil

# Enumerated options
$enum = []

# Other options
$ancestry = false
$content  = false
$dbname   = 'sqlite'
$images   = false
$position = false
$uuid     = false

# Debug flag
$debug = false

module ZtAdmin

  AppRoot         = `pwd`.chomp    # chomp without arguments removes "\n" or "\r\n" if any
  MigratePath     = "#{AppRoot}/db/migrate"
  ModelPath       = "#{AppRoot}/app/models"
  AdminSharedPath = "#{AppRoot}/app/views/admin/shared"
  
  current_dir = AppRoot.split('/').last
  if current_dir.include? '_'
    AppName = current_dir.split('_').map{|e| e.capitalize}.join
  elsif current_dir.include? '-'
    AppName = current_dir.split('-').map{|e| e.capitalize}.join
  else
    AppName = current_dir.capitalize
  end

  def self.root
    File.dirname(__dir__).chomp("/lib")
  end

  def self.assets
    File.join root, 'generic', 'app', 'assets'
  end

  def self.generic_api
    File.join root, 'generic_api'
  end

  def self.bin
    File.join root, 'bin'
  end

  def self.config
    File.join root, 'generic', 'config'
  end

  def self.controllers
    File.join root, 'generic', 'app', 'controllers'
  end

  def self.db
    File.join root, 'generic', 'db'
  end

  def self.generic
    File.join root, 'generic'
  end

  def self.helpers
    File.join root, 'generic', 'app', 'helpers'
  end

  def self.javascript
    File.join root, 'generic', 'app', 'javascript'
  end

  def self.lib
    File.join root, 'generic', 'lib'
  end

  def self.models
    File.join root, 'generic', 'app', 'models'
  end

  def self.policies
    File.join root, 'generic', 'app', 'policies'
  end

  def self.test
    File.join root, 'generic', 'test'
  end

  def self.views
    File.join root, 'generic', 'app', 'views'
  end

  def self.vendor
    File.join root, 'generic', 'vendor'
  end
end
