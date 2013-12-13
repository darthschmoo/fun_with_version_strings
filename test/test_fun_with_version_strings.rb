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
  
  should "compare incorrectly when dealing with regular strings" do
    flunk "not written"
  end
end
