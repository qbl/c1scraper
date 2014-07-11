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
  i = 0
  tps_number = ""
  tps_id = ""
  path_to_scan1 = ""
  path_to_scan2 = ""
  path_to_scan3 = ""
  path_to_scan4 = ""
  doc.xpath('//td').each do |node|
    # Iterating through table of TPS, ignoring the first "td" tag found because it was an empty cell above the table
    # Each row of the TPS table contains 7 cells
    case i
    when 1
      # Cell #1 is the number of TPS
      tps_number = node.text
    when 2
      # Cell #2 is the id (looks like nationwide id) of TPS
      tps_id = node.text
    when 3
      # Cell #3 contains link to image scan #1
      image_id = node.children[1].first[1] unless node.children[1] == nil
      if image_id.include?("javascript:read_jpg")
        image_id = image_id.gsub(/javascript:read_jpg/, "").tr("')('", "")
        path_to_scan1 = "http://scanc1.kpu.go.id/viewp.php?f="+image_id+".jpg"
      else
        path_to_scan1 = "No image uploaded yet at " + Time.now.to_s
      end
    when 4
      # Cell #4 contains link to image scan #2
      image_id = node.children[1].first[1] unless node.children[1] == nil
      if image_id.include?("javascript:read_jpg")
        image_id = image_id.gsub(/javascript:read_jpg/, "").tr("')('", "")
        path_to_scan2 = "http://scanc1.kpu.go.id/viewp.php?f="+image_id+".jpg"
      else
        path_to_scan2 = "No image uploaded yet at " + Time.now.to_s
      end
    when 5
      # Cell #5 contains link to image scan #3
      image_id = node.children[1].first[1] unless node.children[1] == nil
      if image_id.include?("javascript:read_jpg")
        image_id = image_id.gsub(/javascript:read_jpg/, "").tr("')('", "")
        path_to_scan3 = "http://scanc1.kpu.go.id/viewp.php?f="+image_id+".jpg"
      else
        path_to_scan3 = "No image uploaded yet at " + Time.now.to_s
      end
    when 6
      # Cell #6 contains link to image scan #4
      image_id = node.children[1].first[1] unless node.children[1] == nil
      if image_id.include?("javascript:read_jpg")
        image_id = image_id.gsub(/javascript:read_jpg/, "").tr("')('", "")
        path_to_scan4 = "http://scanc1.kpu.go.id/viewp.php?f="+image_id+".jpg"
      else
        path_to_scan4 = "No image uploaded yet at " + Time.now.to_s
      end
      puts "Nomor TPS = " + tps_number + ", ID TPS = " + tps_id + ", File 1 = " + path_to_scan1 + ", File 2 = " + path_to_scan2 + ", File 3 = " + path_to_scan3 + ", File 4 = " + path_to_scan4
    when 7
      # Cell #7 contains link to download all the scan images (4 images above) in one zip file, ignored in this app
      i = 0
    end
    i = i+1
  end
end