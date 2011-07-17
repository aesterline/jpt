require 'set'

module JPT
  def self.dependencies(java_class)
    DependencyExtractor.new.dependencies(java_class)
  end

  class DependencyExtractor
    def dependencies(java_class)
      visitor = DependencyVisitor.new
      java_class = Repository.lookup_class(java_class)
      DescendingVisitor.new(java_class, visitor).visit

      visitor.dependencies
    end
  end

  private
  Repository = org.apache.bcel.Repository
  DescendingVisitor = org.apache.bcel.classfile.DescendingVisitor
  EmptyVisitor = org.apache.bcel.classfile.EmptyVisitor

  class DependencyVisitor < EmptyVisitor
    def dependencies
      @deps ||= Set.new
    end

    def visitJavaClass(java_class)
      dependencies << java_class.class_name
    end

    def visitField(field)
      field.signature.extract_class_names(dependencies)
    end

    def visitConstantPool(constant_pool)
      @constant_pool = constant_pool
    end

    def visitConstantClass(constant_class)
      name = constant_class.get_constant_value(@constant_pool).to_s
      dependencies << name.to_dot_notation
    end

    def visitMethod(method)
      method.signature.extract_class_names(dependencies)
    end

    def visitConstantNameAndType(obj)
      obj.get_signature(@constant_pool).to_s.extract_class_names(dependencies)
    end
  end
end