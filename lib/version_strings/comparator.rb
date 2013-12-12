module FunWith
  module VersionStrings
    module Comparator
      
      # Unless both strings are valid version formats, pass comparison off to super
      def <=>( rhs )
        
        if rhs.is_a?(VersionString) || rhs =~ VersionString::FORMAT_VALIDATOR
          rhs = rhs.fwvs_version_string

          for level in [:major, :minor, :patch]
            unless self.send(level) == rhs.send(level)
              return self.send(level) <=> rhs.send(level)
            end
          end
        
          return 0
        else
          super( rhs )
        end
      end
    end
  end
end