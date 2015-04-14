class ExceptionManager::Methods::Locals
  def self.run(exception_binding)
    exception_binding.eval %q{
      local_variables.inject({}) do |hash, local_variable_name|
        hash[local_variable_name] = eval(local_variable_name.to_s)
        hash
      end
    }
  end
end
