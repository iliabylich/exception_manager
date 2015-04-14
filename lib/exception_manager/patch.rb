module ExceptionManager::ExceptionPatch
  attr_accessor :_binding

  def locals
    ExceptionManager::Methods::Locals.run(_binding)
  end

  def subject
    ExceptionManager::Methods::Subject.run(_binding)
  end

  def subject_instance_variables
    ExceptionManager::Methods::SubjectInstanceVariables.run(_binding)
  end

  def subject_class_variables
    ExceptionManager::Methods::SubjectClassVariables.run(_binding)
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
