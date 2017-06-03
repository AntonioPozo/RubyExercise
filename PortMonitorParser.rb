require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

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

  def initialize(monitor_count, rate, history, multiple_email_notifications, push_notifications, monthly_price, annual_price)
    @monitor_count = monitor_count
  end

end


# load page
page = Nokogiri::HTML(open(ENDPOINT))
# store html divs whose class is "product"
html_products = page.css('div.product')
# iterate over html_products
if html_products.count > 0
  products = Array.new
  # build Product object
  html_products.each do |html_product|
    monitor_count = html_product.css("h2").text
    rate = html_product.css('dl.thin/dd')[0].text.scan(/\d+/)
    history = html_product.css('dl.thin/dd')[1].text.scan(/\d+/)
    multiple_email_notifications = html_product.css('dl.thin/dd')[2].text
    push_notifications = html_product.css('dl.thin/dd')[3].text
    monthly_price = html_product.css('p')[0].text.scan(/\d+\.\d+/)
    annual_price = html_product.css('p')[1].text.scan(/\d+\.\d+/)

    product = Product.new(monitor_count, rate, history, multiple_email_notifications, push_notifications, monthly_price, annual_price)

    # add product to Products array
    products.push(product)
  end
  puts products.to_json

end




#puts page.css('div.product')   # => Nokogiri::HTML::Document