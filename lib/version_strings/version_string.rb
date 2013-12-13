module FunWith
  module VersionStrings
    class VersionString < String
      FORMAT_VALIDATOR = /^(?:(?<major>\d+)\.?)?(?:(?<minor>\d+)\.?)?(?:(?<patch>\d+))?$/
      attr_accessor :major, :minor, :patch
      alias :tiny :patch
      
      # version must be of format n.nn or n.nn.nn
      def initialize( src )
        @match_data = src.match( FORMAT_VALIDATOR )
        raise ArgumentError.new( "Not a valid version format for a VersionString." ) if @match_data.nil?

        @major = (@match_data[:major] || 0).to_i
        @minor = (@match_data[:minor] || 0).to_i
        @patch = (@match_data[:patch] || 0).to_i
        
        super( "#{@major}.#{@minor}.#{@patch}" )
      end
    end
  end
end



