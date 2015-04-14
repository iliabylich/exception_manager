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
      if ExceptionManager.applicable?(tp.raised_exception)
        tp.raised_exception._binding = tp.binding
      end
    end
  end

  def filters
    @filters ||= []
  end

  def add_filter(&block)
    filters << block
  end

  def reset_filters!
    @filters = []
  end

  def applicable?(exception)
    filters.all? do |filter|
      filter.call(exception)
    end
  end

  def logger
    @logger = Logger.new(STDOUT)
  end
  attr_writer :logger

  def required!
    raise ExceptionManager::DisabledError if disabled?
  end
end
