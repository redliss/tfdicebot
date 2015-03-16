require 'cinch'
require 'cinch/plugins/dice'
require 'cinch/plugins/last_seen'
require 'pry'
require_relative 'tfbot'
require_relative 'tfbot/config'

tfdicebot = Cinch::Bot.new do
  configure do |c|
    c.server           = TFBot::Config.server
    c.nick             = TFBot::Config.nick
    c.channels         = TFBot::Config.channels
    c.plugins.plugins  = [Cinch::Plugins::Dice, Cinch::Plugins::LastSeen]
  end

  helpers do
    def descriptions
      @descriptions ||= {
        TFBot::Config.nick => {
        'current' => "The Dicebot is an alien probe, hovering silently just"\
        "out of view, unnoticed. You probably shouldn't be looking at it.",
        'last' => "The Dicebot is an alien probe, hovering silently just"\
        "out of view, unnoticed. You probably shouldn't be looking at it."
      },
        'redliss' => {
        'current' => 'probably some kind of redhead description',
        'last'    => 'empty',
        '1'       => '',
        '2'       => '',
        '3'       => '',
        '4'       => '',
        '5'       => '',
        '6'       => '',
        '7'       => '',
        '8'       => '',
        '9'       => ''
      },
        'HavokX' => {
        'current' => 'probably some kind of subby description',
        'last'    => 'empty',
        '1'       => '',
        '2'       => '',
        '3'       => '',
        '4'       => '',
        '5'       => '',
        '6'       => '',
        '7'       => '',
        '8'       => '',
        '9'       => ''
      }
      }
    end

    def descriptions=(hash)
      @descriptions = hash
    end

    def desc_exists?(nick, desc_name = 'current')
      return false unless user_exists?(nick)

      descriptions[nick].key?(desc_name)
    end

    def user_exists?(nick)
      descriptions.key?(nick)
    end

    def current_desc_for(nick)
      all_descs_for(nick).fetch('current', '')
    end

    def all_descs_for(nick)
      descriptions.fetch(nick, {})
    end

    def specific_desc(nick, desc_name)
      all_descs_for(nick).fetch(desc_name, "That description doesn't exist yet.")
    end

    def set_desc_for(nick, description, desc_name = nil)
      if !user_exists?(nick)
        descriptions[nick] = Hash.new
      end

      descriptions[nick][desc_name] = description if desc_name
      descriptions[nick]['last']   = current_desc_for(nick)
      descriptions[nick]['current'] = description
    end
  end

  on :message, /^!dlist/ do |m|
    if desc_exists?(m.user.nick)
      all_descs_for(m.user.nick).each do |desc|
        m.reply "#{desc.key}: #{desc.value}\n"
      end
    else
      m.reply "You don't have any descriptions stored."
    end
  end

  on :message, /^!ex (.+)/ do |m, nick|
    m.reply("Description for #{nick}: #{current_desc_for(nick)}")
  end

  on :message, /^!tf (.+?) (.+)/ do |m, nick, new_description|
    if nick == m.user.nick
      m.reply "You can't transform yourself."
    elsif nick == bot.nick
      m.reply "You can't transform me. I'm just a bot."
    else
      set_desc_for(nick, new_description)
      m.reply "#{nick} is being transformed!\n#{new_description}"
      set_desc_for(nick, new_description)
    end
  end
end

tfdicebot.start
