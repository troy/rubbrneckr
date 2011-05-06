if ENV["SYSLOG_URL"]
  require "remote_syslog_logger"
  require "uri"

  # redefine Rails.logger
  def Rails.logger
    @@logger ||= begin
      url = URI.parse(ENV["SYSLOG_URL"])
      logger = RemoteSyslogLogger.new(url.host, url.port, :program => url.path[1..-1])
      logger.level = Logger::INFO
      logger
    end
  end

  # borrowed from Rails::Initializer#initialize_framework_logging
  ([ :active_record, :action_controller, :action_mailer ] & Rails.configuration.frameworks).each do |framework|
    framework.to_s.camelize.constantize.const_get("Base").logger = Rails.logger
  end
  ActiveSupport::Dependencies.logger = Rails.logger
  Rails.cache.logger = Rails.logger
end

