module FunWith
  module VersionStrings
    # methods that can be called directly upon the module FunWith::VersionStrings
    module API
      def versionize( obj, version_string )
        if obj.respond_to?(:version)
          warn( "FunWith::VersionStrings (warn):  #{obj.to_s.truncate(100)} already responds to version()")
        end
        
        obj.extend( VersionizeExtender )
        obj.version( version_string )
      end
    end
  end
end
        