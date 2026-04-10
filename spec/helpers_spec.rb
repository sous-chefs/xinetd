# frozen_string_literal: true

require 'spec_helper'
require_relative '../libraries/helpers'

describe Xinetd::Cookbook::Helpers do
  describe '.xinetd_bool' do
    it 'converts true to "yes"' do
      expect(described_class.xinetd_bool(true)).to eq('yes')
    end

    it 'converts false to "no"' do
      expect(described_class.xinetd_bool(false)).to eq('no')
    end
  end

  describe '.xinetd_value' do
    it 'joins arrays with a space' do
      expect(described_class.xinetd_value(%w(HOST PID))).to eq('HOST PID')
    end

    it 'converts true to "yes"' do
      expect(described_class.xinetd_value(true)).to eq('yes')
    end

    it 'converts false to "no"' do
      expect(described_class.xinetd_value(false)).to eq('no')
    end

    it 'passes strings through unchanged' do
      expect(described_class.xinetd_value('SYSLOG daemon info')).to eq('SYSLOG daemon info')
    end

    it 'passes nil through unchanged' do
      expect(described_class.xinetd_value(nil)).to be_nil
    end

    it 'passes integers through unchanged' do
      expect(described_class.xinetd_value(50)).to eq(50)
    end
  end

  describe 'OPTIONS' do
    it 'is a frozen array of symbols' do
      expect(described_class::OPTIONS).to be_a(Array)
      expect(described_class::OPTIONS).to be_frozen
      expect(described_class::OPTIONS).to all(be_a(Symbol))
    end

    it 'includes common xinetd options' do
      %i(id type socket_type wait server port).each do |opt|
        expect(described_class::OPTIONS).to include(opt)
      end
    end
  end
end
