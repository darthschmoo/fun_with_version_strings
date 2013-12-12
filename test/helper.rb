require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'fun_with_version_strings'

include FunWith::VersionStrings

class Test::Unit::TestCase
end

class VersionStringsTestCase < Test::Unit::TestCase
  def assert_valid_version_string( str, opts = {} )
    str = str.fwvs_version_string
    for level in [:major, :minor, :patch]
      if opts[level]
        assert_equal opts[level], str.send(level)
      end
    end
  end
end
