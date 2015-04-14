class ExceptionManager::Methods::SubjectClassVariables
  def self.run(exception_binding)
    ExceptionManager.required!
    exception_binding.eval %q{
      klass = is_a?(Class) ? self : self.class
      klass.class_variables.inject({}) do |hash, class_variable_name|
        hash[class_variable_name] = klass.class_variable_get(class_variable_name)
        hash
      end
    }
  end
end
