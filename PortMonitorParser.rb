require 'rubygems'
require 'nokogiri'
require 'open-uri'

ENDPOINT = "https://port-monitor.com/plans-and-pricing"

class Product

  attr_reader :monitor_count
  attr_reader :rate
  attr_reader :history
  attr_reader :multiple_email_notifications
  attr_reader :push_notifications
  attr_reader :monthly_price
  attr_reader :annual_price

  def monitor_count=(value)
    @monitor_count = Integer(value) rescue nil
  end

  def rate=(value)
    @rate = Integer(value) rescue nil
  end

  def history(value)
    @history = Integer(value) rescue nil
  end

  def multiple_email_notifications(value)
    @multiple_email_notifications = (value == 'Yes' or value == 'No')
  end

  def push_notifications(value)
    @push_notifications = (value == 'Yes' or value == 'No')
  end

  def monthly_price(value)
    @monthly_price = Integer(value) rescue nil
  end

  def annual_price(value)
    @annual_price = Integer(value) rescue nil
  end

end



page = Nokogiri::HTML(open(ENDPOINT))
puts page.class   # => Nokogiri::HTML::Document