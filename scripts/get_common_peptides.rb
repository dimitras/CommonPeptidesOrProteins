# USAGE:
# ruby get_common_peptides.rb ../results/experiment_1_aspirin_only_peptides.xlsx ../results/experiment_2_score_35_positive_reps.xlsx ../data/Experiment_3.xlsx  ../results/overlapped_peptides.xlsx

# create peptide lists with the common peptides between: 1-2-3, 1-2, 1-3, 2-3 experiments

require 'rubygems'
require 'rubyXL'
require 'axlsx'

exp1_file = ARGV[0]
exp2_file = ARGV[1]
exp3_file = ARGV[2]
ofile = ARGV[3]

# initialize arguments
workbook1 = RubyXL::Parser.parse(exp1_file)
workbook2 = RubyXL::Parser.parse(exp2_file)
workbook3 = RubyXL::Parser.parse(exp3_file)

# read the lists (the formats differ)
exp1_list = {}
worksheet1 = workbook1[0]
array1 = worksheet1.extract_data
array1.each do |row|
	if !row[26].eql? "pep_seq"
		exp1_list[row[26]] = row
	end
end

exp2_list = {}
worksheet2 = workbook2[0]
array2 = worksheet2.extract_data
array2.each do |row|
	if !row[3].eql? "PEPTIDE"
		exp2_list[row[3]] = row
	end
end

exp3_list = {}
worksheet3 = workbook3[0]
array3 = worksheet3.extract_data
array3.each do |row|
	if !row[9].eql? "pep_seq"
		exp3_list[row[9]] = row
	end
end

# output
results_xlsx = Axlsx::Package.new
results_wb = results_xlsx.workbook

# create sheet1 - common peptides between 1-2-3 experiments
results_wb.add_worksheet(:name => "1-2-3 overlaps") do |sheet|
	sheet.add_row ["prot_acc", "prot_desc", "genename", "pep_seq", "pep_score", "total_score"]
	exp3_list.each do |peptide, hit|
		if exp2_list.has_key?(peptide) && exp1_list.has_key?(peptide)
			# exp3 format: prot_acc	prot_desc	prot_score	pep_exp_mz	pep_exp_mr	pep_exp_z	pep_delta	pep_score	pep_expect	pep_seq	score (combine)
			prot_acc = hit[0]
			prot_desc = hit[1]
			genename = exp2_list[peptide][2]
			pep_score = hit[7]
			total_score = hit[10]

			sheet.add_row [prot_acc, prot_desc, genename, peptide, pep_score, total_score]
		end
	end
end

# create sheet2 - common peptides between 1-3 experiments
results_wb.add_worksheet(:name => "1-3 overlaps") do |sheet|
	sheet.add_row ["prot_acc", "prot_desc", "genename", "pep_seq", "pep_score", "total_score"]
	exp3_list.each do |peptide, hit|
		if exp1_list.has_key?(peptide)
			# exp3 format: prot_acc	prot_desc	prot_score	pep_exp_mz	pep_exp_mr	pep_exp_z	pep_delta	pep_score	pep_expect	pep_seq	score (combine)
			prot_acc = hit[0]
			prot_desc = hit[1]
			if prot_desc.include? "GN="
				genename = prot_desc.split("GN=")[1].split(" ")[0].to_s
			else
				genename = 'NA'
			end
			pep_score = hit[7]
			total_score = hit[10]

			sheet.add_row [prot_acc, prot_desc, genename, peptide, pep_score, total_score]
		end
	end
end

# create sheet3 - common peptides between 2-3 experiments
results_wb.add_worksheet(:name => "2-3 overlaps") do |sheet|
	sheet.add_row ["prot_acc", "prot_desc", "genename", "pep_seq", "pep_score", "total_score"]
	exp3_list.each do |peptide, hit|
		if exp2_list.has_key?(peptide)
			# exp3 format: prot_acc	prot_desc	prot_score	pep_exp_mz	pep_exp_mr	pep_exp_z	pep_delta	pep_score	pep_expect	pep_seq	score (combine)
			prot_acc = hit[0]
			prot_desc = hit[1]
			genename = exp2_list[peptide][2]
			pep_score = hit[7]
			total_score = hit[10]

			sheet.add_row [prot_acc, prot_desc, genename, peptide, pep_score, total_score]
		end
	end
end

# create sheet4 - common peptides between 1-2 experiments
results_wb.add_worksheet(:name => "1-2 overlaps") do |sheet|
	sheet.add_row ["prot_acc", "prot_desc", "genename", "pep_seq", "pep_score", "total_score"]
	exp2_list.each do |peptide, hit|
		if exp1_list.has_key?(peptide)
			# exp2 format: "PROT_ACC", "PROT_DESC", "GENENAME", "PEPTIDE", "R3", "R4", "R5", "R6", "R7", "R8", "R11", "R12", "R1(-)", "R2(-)", "R9(-)", "R10(-)", "SCORE", "RP", "PENALIZED RP", "hg19", "rn4", "oryCun2", "mm9", "gorGor1", "bosTau4", "danRer6", "galGal3"
			prot_acc = hit[0]
			prot_acc2 = exp1_list[peptide][1]
			prot_desc = hit[1]
			genename = hit[2]
			pep_score = exp1_list[peptide][21]
			total_score = hit[16]

			sheet.add_row [prot_acc + " & " + prot_acc2, prot_desc, genename, peptide, pep_score, total_score]
		end
	end
end

# write xlsx file
results_xlsx.serialize(ofile)
