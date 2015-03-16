require 'yaml'

module TFBot
  module Config
    extend self

    def file
      @file ||= YAML.load(File.read("bot.yml"))
    end

    def server
      file['server']
    end

    def nick
      file['nick']
    end

    def channels
      file['channels']
    end

    def database
      file['database']
    end
  end
end
