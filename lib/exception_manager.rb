require 'exception_manager/version'

module ExceptionManager
  require 'exception_manager/config'
  extend ExceptionManager::Config

  module Methods
    autoload :Locals, 'exception_manager/methods/locals'
    autoload :Subject, 'exception_manager/methods/subject'
    autoload :SubjectInstanceVariables, 'exception_manager/methods/subject_instance_variables'
    autoload :SubjectClassVariables, 'exception_manager/methods/subject_class_variables'
  end

  DisabledError = Class.new(StandardError)
end

require 'exception_manager/patch'
