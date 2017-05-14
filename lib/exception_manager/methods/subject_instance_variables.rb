class ExceptionManager::Methods::SubjectInstanceVariables
  def self.run(exception_binding)
    ExceptionManager.required!
    exception_binding.eval %q{
      instance_variables.each_with_object({}) do |instance_variable_name, hash|
        hash[instance_variable_name] = instance_variable_get(instance_variable_name)
      end
    }
  end
end
