module ExceptionManager::ExceptionPatch
  attr_accessor :_binding

  def locals
    ExceptionManager::Methods::Locals.fetch(_binding)
  end

  def subject
    ExceptionManager::Methods::Subject.fetch(_binding)
  end

  def subject_instance_variables
    ExceptionManager::Methods::SubjectInstanceVariables.fetch(_binding)
  end

  def subject_class_variables
    ExceptionManager::Methods::SubjectClassVariables.fetch(_binding)
  end

  def summary
    {
      locals: locals,
      subject: subject,
      subject_instance_variables: subject_instance_variables,
      subject_class_variables: subject_class_variables
    }
  end
end

Exception.send(:include, ExceptionManager::ExceptionPatch)
