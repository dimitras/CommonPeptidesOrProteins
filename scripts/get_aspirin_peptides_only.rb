# USAGE:
# ruby get_aspirin_peptides_only.rb ../data/Experiment_1_aspirin_ds.xlsx ../data/Experiment_1_control_ds.xlsx ../results/experiment_1_aspirin_only_peptides.csv

# subtract the peptides list and keep only the peptides found in Aspirin set only (and not in the control)

require 'rubygems'
require 'rubyXL'
require 'axlsx'
require 'fastercsv'

aspirin_file = ARGV[0]
control_file = ARGV[1]
ofile = ARGV[2]

# initialize arguments
workbook0 = RubyXL::Parser.parse(aspirin_file)
workbook1 = RubyXL::Parser.parse(control_file)

# read the lists (format: prot_hit_num	prot_acc	prot_desc	prot_score	prot_mass	prot_matches	prot_matches_sig	prot_sequences	prot_sequences_sig	pep_query	pep_rank	pep_isbold	pep_isunique	pep_exp_mz	pep_exp_mr	pep_exp_z	pep_calc_mr	pep_delta	pep_start	pep_end	pep_miss	pep_score	pep_homol	pep_ident	pep_expect	pep_res_before	pep_seq	modifications	pep_res_after	pep_var_mod	modifications	pep_var_mod_pos	pep_scan_title)

aspirin_list = {} #Hash.new { |h,k| h[k] = [] }
worksheet0 = workbook0[0]
array0 = worksheet0.extract_data
array0.each do |row|
	if !row[26].eql? "pep_seq"
		aspirin_list[row[26]] = row
	end
end

control_list = {}
worksheet1 = workbook1[0]
array1 = worksheet1.extract_data
array1.each do |row|
	if !row[26].eql? "pep_seq"
		control_list[row[26]] = row
	end
end

# output
FasterCSV.open(ofile, "w") do |csv|
	csv << ["prot_hit_num", "prot_acc", "prot_desc", "prot_score", "prot_mass", "prot_matches", "prot_matches_sig", "prot_sequences", "prot_sequences_sig", "pep_query", "pep_rank", "pep_isbold", "pep_isunique", "pep_exp_mz", "pep_exp_mr", "pep_exp_z", "pep_calc_mr", "pep_delta", "pep_start", "pep_end", "pep_miss", "pep_score", "pep_homol", "pep_ident", "pep_expect", "pep_res_before", "pep_seq", "modifications", "pep_res_after", "pep_var_mod", "modifications", "pep_var_mod_pos", "pep_scan_title"]
	aspirin_list.each do |peptide, hit|
		if !control_list.has_key?(peptide)
			csv << hit
		end
	end
end
