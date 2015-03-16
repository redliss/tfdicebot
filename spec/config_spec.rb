require 'spec_helper'

describe TFBot::Config do
  let(:server)   { 'irc.freenode.net' }
  let(:nick)     { 'TFBot' }
  let(:channels) { ['##Apuleius', '##ApuleiusCasino', '##ApuleiusTavern'] }
  let(:database) { 'default' }   
                                 
  describe '.server' do
    it 'has a server setting' do
      expect(TFBot::Config.server).to eq(server)
    end
  end

  describe '.nick' do
    it 'has a nick setting' do
      expect(TFBot::Config.nick).to eq(nick)
    end
  end

  describe '.channels' do
    it 'has a channels setting' do
      expect(TFBot::Config.channels).to eq(channels)
    end
  end

  describe '.datebase' do
    it 'has a datebase setting' do
      expect(TFBot::Config.database).to eq(database)
    end
  end
end
