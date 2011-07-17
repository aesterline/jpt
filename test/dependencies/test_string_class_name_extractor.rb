require 'helper'
require 'set'

class ClassNameExtractorTest < Test::Unit::TestCase

  def test_extracting_classname_from_field_signature
    assert_equal(["java.io.ObjectStreamField"], extract_class_names("[Ljava/io/ObjectStreamField;"))
  end

  def test_method_signature_with_one_classname
    assert_equal(["java.lang.Object"], extract_class_names("(Ljava/lang/Object;)I"))
  end

  def test_extracting_classnames_from_method_signature
    signature = "(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;"
    assert_equal(["java.util.Locale", "java.lang.String", "java.lang.Object"], extract_class_names(signature))
  end

  def test_extracting_classnames_from_methods_that_dont_return_object_types
    assert_equal(["java.lang.String", "java.util.Locale"], extract_class_names("(Ljava/lang/String;ILjava/util/Locale;)[C"))
  end

  def test_method_signature_with_no_classes_should_extract_no_classnames
    assert_equal([], extract_class_names("([C)V"))
  end

  def test_inner_class_signatures
    assert_equal(["java.lang.String"], extract_class_names("(Ljava/lang/String$1;)V"))
  end

  private
  def extract_class_names(str)
    class_names = Set.new
    str.extract_class_names(class_names)
    class_names.to_a
  end
end