class ExceptionManager::Methods::Subject < ExceptionManager::Methods::Base
  def self.run(exception_binding)
    exception_binding.eval('self')
  end
end
