module FunWith
  module VersionStrings
    # methods that can be called directly upon the module FunWith::VersionStrings
    module API
      # if no string is given, the given object is assumed to have a root path and
      # to have a file "VERSION" immediately underneath that root.  That's standard for
      # my gems.
      def versionize( obj, version_string = nil )
        if obj.respond_to?(:version)
          warn( "FunWith::VersionStrings (warn):  #{obj.to_s[0..100]} already responds to version().  Leaving alone.")
          return nil
        end
        
        if version_string.nil?
          if obj.respond_to?(:root) && obj.root.is_a?(FunWith::Files::FilePath) && obj.root("VERSION").file?
            version_string = obj.root("VERSION").read
          else
            raise "No version string specified, and cannot infer version from VERSION file."
          end
        end
        
        obj.extend( VersionizeExtender )
        obj.version( version_string )
      end
    end
  end
end
