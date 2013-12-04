# USAGE:
# ruby get_common_proteins_for_4.rb ../results/experiment_1_aspirin_only_peptides_with_uniprot_accno.xlsx ../results/experiment_2_score_35_positive_reps.xlsx ../data/Experiment_3.xlsx ../data/Exp4_K_common_lysine_acetylation_list_11142013.xlsx ../results/overlapped_proteins_for4_forK.xlsx

# create protein lists with the common proteins between: 1-2-3, 1-2, 1-3, 2-3 experiments

require 'rubygems'
require 'rubyXL'
require 'axlsx'

exp1_file = ARGV[0]
exp2_file = ARGV[1]
exp3_file = ARGV[2]
exp4_file = ARGV[3]
ofile = ARGV[4]

# initialize arguments
workbook1 = RubyXL::Parser.parse(exp1_file)
workbook2 = RubyXL::Parser.parse(exp2_file)
workbook3 = RubyXL::Parser.parse(exp3_file)
workbook4 = RubyXL::Parser.parse(exp4_file)

# read the lists (the formats differ)
# prot_hit_num	prot_acc	prot_desc	prot_score	prot_mass	prot_matches	prot_matches_sig	prot_sequences	prot_sequences_sig	pep_query	pep_rank	pep_isbold	pep_isunique	pep_exp_mz	pep_exp_mr	pep_exp_z	pep_calc_mr	pep_delta	pep_start	pep_end	pep_miss	pep_score	pep_homol	pep_ident	pep_expect	pep_res_before	pep_seq	modifications	pep_res_after	pep_var_mod	modifications	pep_var_mod_pos	pep_scan_title
exp1_list = {}
worksheet1 = workbook1[0]
array1 = worksheet1.extract_data
array1.each do |row|
	if !row[56].eql? "uniprot accno"
		exp1_list[row[56]] = row
	end
end

# PROT_ACC 	 PROT_DESC 	 GENENAME	 PEPTIDE 	 R3 	 R4 	 R5 	 R6 	 R7 	 R8 	 R11	 R12	 R1(-) 	 R2(-) 	 R9(-) 	 R10(-)	 SCORE	 RP	 PENALIZED RP	hg19	 rn4	oryCun2	mm9	gorGor1	bosTau4	danRer6	galGal3
exp2_list = {}
worksheet2 = workbook2[0]
array2 = worksheet2.extract_data
array2.each do |row|
	if !row[0].eql? "PROT_ACC"
		exp2_list[row[0]] = row
	end
end

# prot_acc	prot_desc	prot_score	pep_exp_mz	pep_exp_mr	pep_exp_z	pep_delta	pep_score	pep_expect	pep_seq	score (combine)
exp3_list = {}
worksheet3 = workbook3[0]
array3 = worksheet3.extract_data
array3.each do |row|
	if !row[0].eql? "prot_acc"
		exp3_list[row[0]] = row
	end
end

# prot_acc	prot_desc	score	pep_expect	pep_seq	pep_var_mod
exp4_list = {}
worksheet4 = workbook4[0]
array4 = worksheet4.extract_data
array4.each do |row|
	if !row[0].eql? "prot_acc"
		exp4_list[row[0]] = row
	end
end

# output
results_xlsx = Axlsx::Package.new
results_wb = results_xlsx.workbook

# create sheet1 - common peptides between 1-2-3-4 experiments
results_wb.add_worksheet(:name => "1-2-3-4 overlaps") do |sheet|
	sheet.add_row ["prot_acc", "prot_desc", "genename", "pep_seq", "pep_score", "total_score"]
	exp3_list.each do |protein, hit|
		if exp2_list.has_key?(protein) && exp1_list.has_key?(protein) && exp4_list.has_key?(protein)
			# exp3 format: prot_acc	prot_desc	prot_score	pep_exp_mz	pep_exp_mr	pep_exp_z	pep_delta	pep_score	pep_expect	pep_seq	score (combine)
			prot_desc = hit[1]
			genename = exp2_list[protein][2]
			pep_seq = hit[9]
			pep_score = hit[7]
			total_score = hit[10]

			sheet.add_row [protein, prot_desc, genename, pep_seq, pep_score, total_score]
		end
	end
end

# create sheet2 - common peptides between 1-3 experiments
results_wb.add_worksheet(:name => "1-3 overlaps") do |sheet|
	sheet.add_row ["prot_acc", "prot_desc", "genename", "pep_seq", "pep_score", "total_score"]
	exp3_list.each do |protein, hit|
		if exp1_list.has_key?(protein)
			# exp3 format: prot_acc	prot_desc	prot_score	pep_exp_mz	pep_exp_mr	pep_exp_z	pep_delta	pep_score	pep_expect	pep_seq	score (combine)
			prot_desc = hit[1]
			if prot_desc.include? "GN="
				genename = prot_desc.split("GN=")[1].split(" ")[0].to_s
			else
				genename = 'NA'
			end
			pep_seq = hit[9]
			pep_score = hit[7]
			total_score = hit[10]

			sheet.add_row [protein, prot_desc, genename, pep_seq, pep_score, total_score]
		end
	end
end

# create sheet3 - common peptides between 2-3 experiments
results_wb.add_worksheet(:name => "2-3 overlaps") do |sheet|
	sheet.add_row ["prot_acc", "prot_desc", "genename", "pep_seq", "pep_score", "total_score"]
	exp3_list.each do |protein, hit|
		if exp2_list.has_key?(protein)
			# exp3 format: prot_acc	prot_desc	prot_score	pep_exp_mz	pep_exp_mr	pep_exp_z	pep_delta	pep_score	pep_expect	pep_seq	score (combine)
			prot_desc = hit[1]
			genename = exp2_list[protein][2]
			pep_seq = hit[9]
			pep_score = hit[7]
			total_score = hit[10]

			sheet.add_row [protein, prot_desc, genename, pep_seq, pep_score, total_score]
		end
	end
end

# create sheet4 - common peptides between 1-2 experiments
results_wb.add_worksheet(:name => "1-2 overlaps") do |sheet|
	sheet.add_row ["prot_acc", "prot_desc", "genename", "pep_seq", "pep_score", "total_score"]
	exp2_list.each do |protein, hit|
		if exp1_list.has_key?(protein)
			# exp2 format: "PROT_ACC", "PROT_DESC", "GENENAME", "PEPTIDE", "R3", "R4", "R5", "R6", "R7", "R8", "R11", "R12", "R1(-)", "R2(-)", "R9(-)", "R10(-)", "SCORE", "RP", "PENALIZED RP", "hg19", "rn4", "oryCun2", "mm9", "gorGor1", "bosTau4", "danRer6", "galGal3"
			prot_desc = hit[1]
			genename = hit[2]
			pep_seq = hit[3]
			pep_score = exp1_list[protein][21]
			total_score = hit[16]

			sheet.add_row [protein, prot_desc, genename, pep_seq, pep_score, total_score]
		end
	end
end

# create sheet5 - common peptides between 1-4 experiments
results_wb.add_worksheet(:name => "1-4 overlaps") do |sheet|
	sheet.add_row ["prot_acc", "prot_desc", "genename", "pep_seq", "pep_score", "total_score"]
	exp4_list.each do |protein, hit|
		if exp1_list.has_key?(protein)
			#exp4: prot_acc	prot_desc	score	pep_expect	pep_seq	pep_var_mod
			prot_desc = hit[1]
			if prot_desc.include? "GN="
				genename = prot_desc.split("GN=")[1].split(" ")[0].to_s
			else
				genename = 'NA'
			end
			pep_seq = hit[4]
			pep_score = exp1_list[protein][21]
			total_score = hit[2]

			sheet.add_row [protein, prot_desc, genename, pep_seq, pep_score, total_score]
		end
	end
end

# create sheet6 - common peptides between 2-4 experiments
results_wb.add_worksheet(:name => "2-4 overlaps") do |sheet|
	sheet.add_row ["prot_acc", "prot_desc", "genename", "pep_seq", "pep_score", "total_score"]
	exp4_list.each do |protein, hit|
		if exp2_list.has_key?(protein)
			#exp4: prot_acc	prot_desc	score	pep_expect	pep_seq	pep_var_mod
			prot_desc = hit[1]
			if prot_desc.include? "GN="
				genename = prot_desc.split("GN=")[1].split(" ")[0].to_s
			else
				genename = 'NA'
			end
			pep_seq = hit[4]
			pep_score = 'NA'
			total_score = hit[2]

			sheet.add_row [protein, prot_desc, genename, pep_seq, pep_score, total_score]
		end
	end
end

# create sheet7 - common peptides between 3-4 experiments
results_wb.add_worksheet(:name => "3-4 overlaps") do |sheet|
	sheet.add_row ["prot_acc", "prot_desc", "genename", "pep_seq", "pep_score", "total_score"]
	exp4_list.each do |protein, hit|
		if exp3_list.has_key?(protein)
			#exp4: prot_acc	prot_desc	score	pep_expect	pep_seq	pep_var_mod
			prot_desc = hit[1]
			if prot_desc.include? "GN="
				genename = prot_desc.split("GN=")[1].split(" ")[0].to_s
			else
				genename = 'NA'
			end
			pep_seq = hit[4]
			pep_score = exp3_list[protein][7]
			total_score = hit[2]

			sheet.add_row [protein, prot_desc, genename, pep_seq, pep_score, total_score]
		end
	end
end


# write xlsx file
results_xlsx.serialize(ofile)
