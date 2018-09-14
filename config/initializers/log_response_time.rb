# frozen_string_literal: true

event_logger = ::Logger.new("#{Rails.root}/log/response_times.log")
event_logger.formatter = proc { |_severity, _datetime, _progname, msg|
  "#{msg}\n"
}

ActiveSupport::Notifications.subscribe(
  'process_action.action_controller'
) do |_, started, finished, _, stats|
  request_time = (finished - started) * 1000
  controller = stats[:controller][0..-11].underscore
  action = "#{stats[:method]} #{controller}##{stats[:action]}.#{stats[:format]}"

  event_logger.info "#{action} | Status: #{stats[:status]} | "\
                    "Total: #{request_time} | "\
                    "ActiveRecord: #{stats[:db_runtime]} | "\
                    "Views: #{stats[:view_runtime]}"
end
