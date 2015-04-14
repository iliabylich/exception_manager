class ExceptionManager::Methods::Subject
  def self.run(exception_binding)
    exception_binding.eval('self')
  end
end
