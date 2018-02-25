namespace :amc do
  desc "Initial Data"
  task :initial => :environment do
    require 'open-uri'
    require 'nokogiri'
    require 'mechanize'
    url = 'http://portal.amfiindia.com/DownloadNAVHistoryReport_Po.aspx?mf=53&tp=1&frmdt=01-Apr-2015&todt=22-Feb-2018'
    agent = Mechanize.new
    amc = agent.get(url)
    response = Nokogiri::HTML(amc.body)
    row = response.css('p')[0].content.split("Axis Mutual Fund\r\n")
    row.each do |r|
      each_row = r.split("\r\n")
      each_row.each do |e|
        amc_data = e.split(";")
        if amc_data[0].to_i != 0 && Math.log10(amc_data[0].to_i).to_i > 2
          amc = Amc.create(:scheme_code => amc_data[0],:scheme_name => amc_data[1],:net_asset_value => amc_data[2],:repurchase_price => amc_data[3],:sale_price => amc_data[4],:on_date => amc_data[5])
          p amc.id
        end
      end
    end
  end
end