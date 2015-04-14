class ExceptionManager::Methods::Subject
  def self.run(exception_binding)
    ExceptionManager.required!
    exception_binding.eval('self')
  end
end
