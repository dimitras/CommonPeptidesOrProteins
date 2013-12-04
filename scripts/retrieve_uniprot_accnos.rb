# USAGE: ruby retrieve_uniprot_accnos.rb ../results/experiment_1_aspirin_only_peptides_with_accno.csv ../data/ucsc_known_hg19_info.csv ../results/experiment_1_aspirin_only_peptides_with_uniprot_accno.csv

require "csv"  

exp1_file = ARGV[0]
ucsc_human_known_file = ARGV[1]
outfile = ARGV[2]

# 14 hg19.kgXref.spID
# 17 hg19.kgXref.protAcc

ucsc_human_known = {}
CSV.foreach(ucsc_human_known_file) do |row|
	if !row[1].eql?("hg19.kgXref.geneSymbol")
		ucsc_human_known[row[17]] = row[14]
	end
end

# 55 NP_accno

exp1_proteins = Hash.new { |h,k| h[k] = [] }
CSV.foreach(exp1_file) do |row|
	if !row[1].eql?("prot_hit_num")
		np_accno = row[55].split('.')[0]
		if ucsc_human_known.has_key?(np_accno)
			row_updated = row << ucsc_human_known[np_accno]
			exp1_proteins[row[55]] << row_updated
		end
	end
end
puts exp1_proteins.inspect

CSV.open(outfile, "w") do |csv|
	csv << ["prot_hit_num", "prot_acc", "prot_desc", "prot_score", "prot_mass", "prot_matches", "prot_matches_sig", "prot_sequences", "prot_sequences_sig", "pep_query", "pep_rank", "pep_isbold", "pep_isunique", "pep_exp_mz", "pep_exp_mr", "pep_exp_z", "pep_calc_mr", "pep_delta", "pep_start", "pep_end", "pep_miss", "pep_score", "pep_homol", "pep_ident", "pep_expect", "pep_res_before", "pep_seq", "modifications", "pep_res_after", "pep_var_mod", "modifications", "pep_var_mod_pos", "pep_scan_title", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "NP_accno", "uniprot accno"]
	exp1_proteins.each do |peptide, hits|
		hits.each do |hit|
			csv << hit
		end
	end
end