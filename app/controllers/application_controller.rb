# frozen_string_literal: true

require 'objspace'

class ApplicationController < ActionController::Base
  around_action :track_object_allocation

  def allocation_logger
    @@allocation_logger ||= begin
      logger = Logger.new("#{Rails.root}/log/allocation_trace.log")
      logger.formatter = proc { |_severity, _datetime, _progname, msg|
        "#{msg}\n"
      }
      logger
    end
  end

  def track_object_allocation
    gc_stats = GC.stat
    prev_allocated = gc_stats[:total_allocated_objects]
    prev_freed = gc_stats[:total_freed_objects]

    yield

    gc_stats = GC.stat
    post_allocated = gc_stats[:total_allocated_objects]
    post_freed = gc_stats[:total_freed_objects]

    allocation_logger.info(
      "#{request.parameters['controller']}##{request.parameters['action']}."\
      "#{request.format.to_sym} | "\
      "Allocated: #{post_allocated - prev_allocated} | "\
      "Freed: #{post_freed - prev_freed}"
    )
  end
end
