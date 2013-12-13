module FunWith
  module VersionStrings
    module VersionizeExtender
      def version( str = nil )
        @fwvs_version_string ||= str.fwvs_version_string
        @fwvs_version_string
      end
    end
  end
end