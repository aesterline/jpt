class String
  def extract_class_names(collection)
    self.scan(/L(j[^;]+);/).each do |class_name|
      possible_class_name = class_name[0]
      possible_class_name.gsub!(/\$.*/, '')
      collection << possible_class_name.to_dot_notation
    end
  end

  def to_dot_notation
    self.gsub('/', '.')
  end
end