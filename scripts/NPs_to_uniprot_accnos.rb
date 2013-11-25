# NOT FINISHED #

require 'rubygems'
require 'rubyXL'
require 'nokogiri'
require 'open-uri'


ifile = ARGV[0]

# initialize arguments
workbook = RubyXL::Parser.parse(ifile)

# read the list
protein_list = Hash.new { |h,k| h[k] = [] }
worksheet = workbook[0]
array = worksheet.extract_data
array.each do |row|
	if !row[55].include? "NP_accno"
		url = "http://www.ncbi.nlm.nih.gov/protein/" + row[55].to_s
		protein_page = Nokogiri::HTML(open(url))
		if row[55]=="NP_037506.2"
			puts url
			protein_page.search(row[55]).each do |item|
			# protein_page.css('.genbank').each do |item|
				puts item#.content
				# row_updated = row + uniprot_accno.content
				# protein_list[row[0]] = row_updated
			end
		end
		break

		# reviews = []
		# protein_page.css('.genbank').each do |uniprot_accno|
		#   uniprot_accno = uniprot_accno.css('.description .notranslate text()').map(&:to_s)
		#   reviews << {'pro' => pro, 'con' => con, 'advice' => advice}
		# end

	end
end
