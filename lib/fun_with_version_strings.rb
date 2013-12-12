require 'fun_with_files'

root = __FILE__.fwf_filepath.dirname.up

for requirement in root.join("lib", "version_strings").glob( :ext => "rb", :recursive => true )
  require requirement
end

FunWith::Files::RootPath.rootify( FunWith::VersionStrings, root )
FunWith::VersionStrings::VersionString.send( :include, FunWith::VersionStrings::Comparator )
FunWith::VersionStrings.extend( FunWith::VersionStrings::API )
FunWith::VersionStrings.versionize( FunWith::VersionStrings, root.join("VERSION").read )

