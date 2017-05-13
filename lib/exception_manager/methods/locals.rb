class ExceptionManager::Methods::Locals
  def self.run(exception_binding)
    ExceptionManager.required!
    exception_binding.eval %q{
      local_variables.each_with_object({}) do |local_variable_name, hash|
        hash[local_variable_name] = eval(local_variable_name.to_s)
      end
    }
  end
end
