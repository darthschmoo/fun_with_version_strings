require 'helper'

class TestFunWithVersionStrings < VersionStringsTestCase
  context "setup" do
    should "respond to all the things" do
      assert "".respond_to?(:fwvs_version_string), "String not responding"
      assert FunWith::VersionStrings.respond_to?(:root), "FunWith::VersionStrings not responding to root"
      assert FunWith::VersionStrings.respond_to?(:versionize), "FunWith::VersionStrings not responding to versionize"
    end    
  end
  
  
  should "accept the following strings as version formats" do
    assert_valid_version_string( "", {:major => 0, :minor => 0, :patch => 0})
    assert_valid_version_string( "0.", {:major => 0, :minor => 0, :patch => 0})
    assert_valid_version_string( "0.0", {:major => 0, :minor => 0, :patch => 0})
    assert_valid_version_string( "0.0.", {:major => 0, :minor => 0, :patch => 0})
    assert_valid_version_string( "0.0.0", {:major => 0, :minor => 0, :patch => 0})
  end
  
  should "compare things correctly" do
    # larger always comes first
    gt_comparisons = [
      ["1.7","1.4"],
      ["0.9","0.8"],
      ["0.0.1",""],
      ["0.0.1","0.0."],
      ["3.14159","3.141"],
      ["1",""]
    ]
    
    eq_comparisons = [
      ["0.0.0",""],
      ["1.0.0","1.0"],
      ["1.0.","1"],
      ["3.1.1","3.1.1"],
      ["3","3.0."],
      ["2.4","2.4.0"]
    ]
    
    for c in gt_comparisons
      assert( c.first.fwvs_version_string > c.last.fwvs_version_string, "#{c.first.inspect} should be greater than #{c.last.inspect}" )
    end
    
    for c in eq_comparisons
      assert_equal( c.first.fwvs_version_string, c.last.fwvs_version_string )
    end
  end
  
  context "trying it out" do
    should "be able to call .version() on a class" do
      versioned_module do
        assert @module.version.length == 5, "@module.version.length == 5"
      end
    end
  end
  
  context "trying out default approach to finding a module version" do
    should "raise error when no string given" do
      mod = Module.new

      assert_raises( RuntimeError ) do
        FunWith::VersionStrings.versionize( @module )
      end
    end
    
    should "raise error when root has no VERSION file" do
      mod = Module.new
      FunWith::Files::RootPath.rootify(mod, FunWith::VersionStrings.root("test"))
      assert_raises( RuntimeError ) do
        FunWith::VersionStrings.versionize( @module )
      end
    end
    
    should "set version by VERSION file when module has a root" do
      mod = Module.new
      FunWith::Files::RootPath.rootify( mod, FunWith::VersionStrings.root )
      FunWith::VersionStrings.versionize( mod )
      assert FunWith::VersionStrings.respond_to?(:version)
      assert mod.respond_to?(:version)
      assert_equal FunWith::VersionStrings.version, mod.version
    end
  end
  
  should "compare as strings when compared string doesn't fit the format" do
    v = "10.0.10".fwvs_version_string
    
    comparisons = [[1, "0a"], 
                   [1, "--"],
                   [1, "..?"],
                   [-1, "5 is a number"]
                  ]
                   
    
    for compare in comparisons
      assert_equal compare.first, ( v <=> compare.last )
    end
  end
end
