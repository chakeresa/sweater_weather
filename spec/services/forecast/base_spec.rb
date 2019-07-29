require 'rails_helper'

describe Forecast::Base do
  it 'exists' do
    expect(subject).to be_a(Forecast::Base)
  end

  it 'has methods dealing with time' do
    utc_offset = -6
    forecast = Forecast::Base.new(forecast_hash: { offset: utc_offset })

    expect(forecast.utc_offset).to eq(utc_offset)

    epoch = 1564264800

    expect(forecast.time(epoch)).to eq("4:00 PM")
    expect(forecast.hour(epoch)).to eq("4 PM")
    expect(forecast.date(epoch)).to eq("7/27")
    expect(forecast.day_of_week(epoch)).to eq("Saturday")
  end

  it 'determines uv intensity' do
    forecast = Forecast::Base.new

    expect(forecast.uv_intensity(0)).to eq('low')
    expect(forecast.uv_intensity(1)).to eq('low')
    expect(forecast.uv_intensity(2.9)).to eq('low')

    expect(forecast.uv_intensity(3)).to eq('moderate')
    expect(forecast.uv_intensity(4.4675)).to eq('moderate')
    expect(forecast.uv_intensity(5.9)).to eq('moderate')

    expect(forecast.uv_intensity(6.0)).to eq('high')
    expect(forecast.uv_intensity(7.3)).to eq('high')
    expect(forecast.uv_intensity(7.999)).to eq('high')

    expect(forecast.uv_intensity(8)).to eq('very high')
    expect(forecast.uv_intensity(8.1)).to eq('very high')
    expect(forecast.uv_intensity(10.9)).to eq('very high')
    
    expect(forecast.uv_intensity(11)).to eq('extreme')
    expect(forecast.uv_intensity(1000)).to eq('extreme')
  end
end
