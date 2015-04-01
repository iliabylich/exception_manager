require 'logger'

module ExceptionManager::Config
  def enable!
    tracepoint.enable
  end

  def disable!
    tracepoint.disable
  end

  def enabled?
    tracepoint.enabled?
  end

  def disabled?
    !enabled?
  end

  def tracepoint
    @tracepoint ||= TracePoint.new(:raise) do |tp|
      tp.raised_exception._binding = tp.binding
    end
  end

  def filters
    @filters ||= []
  end

  def add_filter(&block)
    filters << block
  end

  def reset_filters!
    @fliters = []
  end

  def logger
    @logger = Logger.new(STDOUT)
  end
  attr_writer :logger

  module Notifications
    WARN = :warn
    RAISE = :raise
    NO = :no
  end

  def notification_level
    @notification_level ||= Notifications::WARN
  end

  def notify_with(level)
    @notification_level = level
  end
end
