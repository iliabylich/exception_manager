class ExceptionManager::Methods::SubjectInstanceVariables < ExceptionManager::Methods::Base
  def self.run(exception_binding)
    exception_binding.eval %q{
      instance_variables.inject({}) do |hash, instance_variable_name|
        hash[instance_variable_name] = instance_variable_get(instance_variable_name)
        hash
      end
    }
  end
end
