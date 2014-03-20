class String
  def fwvs_version_string
    FunWith::VersionStrings::VersionString.new( self )
  end
end