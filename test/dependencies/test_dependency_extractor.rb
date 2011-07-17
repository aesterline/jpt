require 'helper'

class TestDependencyExtractor < Test::Unit::TestCase

  def test_dependencies_are_not_duplicated
    extractor = JPT::DependencyExtractor.new
    dependencies = extractor.dependencies(java.lang.Math.java_class)

    assert_include_only(["java.util.Random", "java.lang.Math", "java.lang.Object", "java.lang.StrictMath", "java.lang.Float", "java.lang.Double", "sun.misc.FpUtils"], dependencies)
  end

  def assert_include_only(expected, actual)
    all_actual_in_expected = actual.all? {|item| expected.include?(item) }
    all_expected_in_actual = expected.all? {|item| actual.include?(item) }

    assert(all_actual_in_expected && all_expected_in_actual)
  end

end