module ExceptionManager::Notifier
  ManagerDisabledError = Class.new(StandardError)
  extend self

  def notification_level
    ExceptionManager.notification_level
  end

  def with_notification
    notify! if ExceptionManager.disabled?
    yield
  end

  ERROR_MESSAGE = 'ExceptionManager is disabled, you should enable it first'
  include ExceptionManager::Config::Notifications

  def notify!
    case notification_level
    when WARN
      ExceptionManager.logger.warn(ERROR_MESSAGE)
    when RAISE
      raise ManagerDisabledError, ERROR_MESSAGE
    when NO
      # ...
    end
  end
end
