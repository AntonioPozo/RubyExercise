require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

ENDPOINT = 'https://port-monitor.com/plans-and-pricing'

class Product

  def initialize(monitor_count, rate, history, multiple_email_notifications, push_notifications, monthly_price, annual_price)
    @monitor_count = monitor_count
    @rate = rate
    @history = history
    @multiple_email_notifications = multiple_email_notifications
    @push_notifications = push_notifications
    @monthly_price = monthly_price
    @annual_price = annual_price
  end

  def product_hash
    hash = {
        monitor_count: @monitor_count,
        rate: @rate,
        history: @history,
        multiple_email_notifications: @multiple_email_notifications,
        push_notifications: @push_notifications,
        monthly_price: @monthly_price,
        annual_price: @annual_price
    }
    return hash
  end

end


# load page
page = Nokogiri::HTML(open(ENDPOINT))
# store html divs whose class is "product"
html_products = page.css('div.product')
if html_products.count > 0
  products = Array.new
  # iterate over html_products
  html_products.each do |html_product|
    monitor_count = html_product.css("h2").text.to_i
    rate = html_product.css('dl.thin/dd')[0].text.scan(/\d+/).first.to_i
    history = html_product.css('dl.thin/dd')[1].text.scan(/\d+/).first.to_i
    multiple_email_notifications = html_product.css('dl.thin/dd')[2].text
    push_notifications = html_product.css('dl.thin/dd')[3].text
    monthly_price = html_product.css('p')[0].text.scan(/\d+\.\d+/).first.to_f
    annual_price = html_product.css('p')[1].text.scan(/\d+\.\d+/).first.to_f
    # build Product object
    product = Product.new(monitor_count, rate, history, multiple_email_notifications, push_notifications, monthly_price, annual_price)
    # add product hash to Products array
    products.push(product.product_hash)
  end
  puts JSON.pretty_generate(products)
end
