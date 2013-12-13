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
  
  def versioned_module( &block )
    @module = Module.new
    
    assert !( @module.respond_to?( :version ) ), "New module shouldn't respond to :version method."
    
    FunWith::VersionStrings.versionize( @module, "3.1.2" )
    assert @module.respond_to?( :version ), "New module should respond to :version method."
    
    assert @module.version.is_a?(String), "@module.version should yield a string"
    assert @module.version.is_a?(FunWith::VersionStrings::VersionString), "@module.version should yield a VersionString"
    yield
  end
end
