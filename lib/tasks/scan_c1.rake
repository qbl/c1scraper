desc "Fetch all TPS data"
task :fetch_tps => :environment do |tps|
  require 'nokogiri'
  require 'open-uri'

  # National Level
  url = "http://pilpres2014.kpu.go.id/c1.php"
  doc = Nokogiri::HTML(open(url))
  puts doc.at_css("title").text
  doc.xpath('//select[@class="formfield"]/option').each do | node|
    puts "kode = " + node['value'] + ", nama = " + node.text
  end

  puts ""


  # Province Level
  url = "http://pilpres2014.kpu.go.id/c1.php?cmd=select&grandparent=0&parent=6728"
  doc = Nokogiri::HTML(open(url))
  puts "Provinsi Sumatera Utara"
  doc.xpath('//select[@class="formfield"]/option').each do | node|
    puts "kode = " + node['value'] + ", nama = " + node.text
  end

  puts ""

  # District Level
  url = "http://pilpres2014.kpu.go.id/c1.php?cmd=select&grandparent=6728&parent=7240"
  doc = Nokogiri::HTML(open(url))
  puts "Kabupaten Tapanuli Tengah"
  doc.xpath('//select[@class="formfield"]/option').each do | node|
    puts "kode = " + node['value'] + ", nama = " + node.text
  end

  puts ""

  # Subdistrict Level
  url = "http://pilpres2014.kpu.go.id/c1.php?cmd=select&grandparent=7240&parent=7241"
  doc = Nokogiri::HTML(open(url))
  puts "Kecamatan Barus"
  doc.xpath('//select[@class="formfield"]/option').each do | node|
    puts "kode = " + node['value'] + ", nama = " + node.text
  end

  puts ""

  # Village Level
  url = "http://pilpres2014.kpu.go.id/c1.php?cmd=select&grandparent=7241&parent=7242"
  doc = Nokogiri::HTML(open(url))
  puts "Kelurahan Pasar Batu Gerigis"
end