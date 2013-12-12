class String
  def fwvs_version_string
    if self.is_a?(FunWith::VersionStrings::VersionString)
      self.dup
    else
      FunWith::VersionStrings::VersionString.new( self )
    end
  end
end