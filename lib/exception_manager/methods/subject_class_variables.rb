class ExceptionManager::Methods::SubjectClassVariables
  def self.run(exception_binding)
    ExceptionManager.required!
    exception_binding.eval %q{
      klass = is_a?(Class) ? self : self.class
      klass.class_variables.each_with_object({}) do |class_variable_name, hash|
        hash[class_variable_name] = klass.class_variable_get(class_variable_name)
      end
    }
  end
end
