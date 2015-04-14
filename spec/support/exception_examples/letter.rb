# @example
#  letter = Letter.new('message', 'sender@example.com')
#  letter.deliver_to('recipient@example.com')
#
#  CannotDeliverMessageError: 'recipient@example.com' does not want to receive emails from you
#
CannotDeliverMessageError = Class.new(StandardError)

class Letter
  attr_reader :message, :sender
  @@class_variable = 'class variable'

  def initialize(message, sender)
    @message = message
    @sender = sender
  end

  def deliver_to(recipient)
    exception_message = "'#{recipient}' does not want to receive emails from you"
    raise CannotDeliverMessageError, exception_message
  end
end
