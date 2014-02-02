require 'fun_with_files'

module FunWith
  module VersionStrings
  end
end

root = __FILE__.fwf_filepath.dirname.up

root.join( "lib", "version_strings" ).requir

FunWith::Files::RootPath.rootify( FunWith::VersionStrings, root )
FunWith::VersionStrings::VersionString.send( :include, FunWith::VersionStrings::Comparator )
FunWith::VersionStrings.extend( FunWith::VersionStrings::API )
FunWith::VersionStrings.versionize( FunWith::VersionStrings, root.join( "VERSION" ).read )

