require 'nokogiri'
require 'open-uri'
require 'spreadsheet'

desc "Fetch all TPS data"

task :fetch_provinces => :environment do
  @provinces = get_provinces
  @provinces.each do |province|
    puts "Kode: " + province[:id] + ", " + province[:name]
  end
end

task :generate_excel, :province_id do |t, args|
  book = Spreadsheet::Workbook.new
  sheet1 = book.create_worksheet
  row = sheet1.row(0)
  row.push "Kabupaten/Kota", "Kecamatan", "Kelurahan/Desa", "Nomor TPS", "ID TPS", "Scan 1", "Scan 2", "Scan 3", "Scan 4", "Jumlah Suara Prabowo-Hatta", "Jumlah Suara Jokowi-JK"

  i = 1
  @districts = get_districts(args[:province_id])
  @districts.each do |district|
    @subdistricts = get_subdistricts(args[:province_id], district[:id])
    @subdistricts.each do |subdistrict|
      @villages = get_villages(district[:id], subdistrict[:id])
      @villages.each do |village|
        @tpses = get_tpses(subdistrict[:id], village[:id])
        @tpses.each do |tps|
          sheet1.row(i).push district[:name], subdistrict[:name], village[:name], tps[:tps_number], tps[:tps_id], tps[:scan1], tps[:scan2], tps[:scan3], tps[:scan4]
          i = i+1
        end
      end
    end
  end

  book.write 'Test.xls'
end

def get_provinces
  url = "http://pilpres2014.kpu.go.id/c1.php"
  doc = Nokogiri::HTML(open(url))
  @provinces = []

  doc.xpath('//select[@class="formfield"]/option').each do |node|
    @provinces << {:id => node['value'], :name => node.text} unless node.text == "pilih"
  end

  return @provinces
end

def get_districts(province_id)
  districts_url = "http://pilpres2014.kpu.go.id/c1.php?cmd=select&grandparent=0&parent=#{province_id}"
  districts_doc = Nokogiri::HTML(open(districts_url))
  @districts = []

  districts_doc.xpath('//select[@class="formfield"]/option').each do |node|
    @districts << {:id => node['value'], :name => node.text} unless node.text == "pilih"
  end

  return @districts
end

def get_subdistricts(province_id, district_id)
  subdistricts_url = "http://pilpres2014.kpu.go.id/c1.php?cmd=select&grandparent=#{province_id}&parent=#{district_id}"
  subdistricts_doc = Nokogiri::HTML(open(subdistricts_url))
  @subdistricts = []
  subdistricts_doc.xpath('//select[@class="formfield"]/option').each do | node|
    @subdistricts << {:id => node['value'], :name => node.text} unless node.text == "pilih"
  end

  return @subdistricts
end

def get_villages(district_id, subdistrict_id)
  villages_url = "http://pilpres2014.kpu.go.id/c1.php?cmd=select&grandparent=#{district_id}&parent=#{subdistrict_id}"
  villages_doc = Nokogiri::HTML(open(villages_url))
  @villages = []
  villages_doc.xpath('//select[@class="formfield"]/option').each do | node|
    @villages << {:id => node['value'], :name => node.text} unless node.text == "pilih"
  end

  return @villages
end

def get_tpses(subdistrict_id, village_id)
  tpses_url = "http://pilpres2014.kpu.go.id/c1.php?cmd=select&grandparent=#{subdistrict_id}&parent=#{village_id}"
  tpses_doc = Nokogiri::HTML(open(tpses_url))
  @tpses = []

  i = 0
  tps_number = ""
  tps_id = ""
  path_to_scan1 = ""
  path_to_scan2 = ""
  path_to_scan3 = ""
  path_to_scan4 = ""
  tpses_doc.xpath('//td').each do |node|
    # Iterating through table of TPS, ignoring the first "td" tag found because it is an empty cell above the table
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
      @tpses << {:tps_number => tps_number, :tps_id => tps_id, :scan1 => path_to_scan1, :scan2 => path_to_scan2, :scan3 => path_to_scan3, :scan4 => path_to_scan4}
    when 7
      # Cell #7 contains link to download all the scan images (4 images above) in one zip file, ignored in this app
      i = 0
    end
    i = i+1
  end

  return @tpses
end