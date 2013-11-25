# USAGE:
# ruby get_peptides_of_score_and_sign.rb ../data/experiment_2_score_35_ds.xlsx ../results/experiment_2_score_35_positive_reps.csv

# filter the peptides that have total score (only through the positive replicates) larger than 35

require 'rubygems'
require 'rubyXL'
require 'axlsx'
require 'fastercsv'

ifile = ARGV[0]
ofile = ARGV[1]

# initialize arguments
workbook = RubyXL::Parser.parse(ifile)

# read the lists (format: PROT_ACC 	 PROT_DESC 	 GENENAME	 PEPTIDE 	 R3 	 R4 	 R5 	 R6 	 R7 	 R8 	 R11	 R12	 R1(-) 	 R2(-) 	 R9(-) 	 R10(-)	 SCORE	 RP	 PENALIZED RP	hg19	 rn4	oryCun2	mm9	gorGor1	bosTau4	danRer6	galGal3)
peptide_list = Hash.new { |h,k| h[k] = [] }
worksheet = workbook[0]
array = worksheet.extract_data
array.each do |row|
	if !row[0].include? "PROT_ACC"
		if row[16] >= 35.0
			if (row[12]==0) && (row[13]==0) && (row[14]==0) && (row[15]==0)
				peptide_list[row[0]] = row
			end
		end
	end
end

# output
FasterCSV.open(ofile, "w") do |csv|
	csv << ["PROT_ACC", "PROT_DESC", "GENENAME", "PEPTIDE", "R3", "R4", "R5", "R6", "R7", "R8", "R11", "R12", "R1(-)", "R2(-)", "R9(-)", "R10(-)", "SCORE", "RP", "PENALIZED RP", "hg19", "rn4", "oryCun2", "mm9", "gorGor1", "bosTau4", "danRer6", "galGal3"]
	peptide_list.each do |protein, hit|
		csv << hit
	end
end

