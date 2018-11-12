
##service manual
suppressPackageStartupMessages(require(optparse))

option_list = list(
  make_option(c("-i", "--input"), type="character", default=NULL,help="Input file name. The file output from GATK'S VariantsToTable. [required]", 
              metavar="character"),
  make_option(c("-o", "--output"), type="character", default="vcf_converted_to_hapmap.txt",help="output file name [default= %default]", 
              metavar="character")
)
opt_parser = OptionParser(usage = "usage: %prog [options] args",option_list=option_list)
opt = parse_args(opt_parser)

if (is.null(opt$input)){
  print_help(opt_parser)
  #stop("At least one argument must be supplied (input file)", call.=TRUE)
  stop("The input file must be supplied")
}

vcf <- read.table(opt$input, header=TRUE, stringsAsFactors = FALSE)

rs <- paste(vcf$CHROM, vcf$POS, sep = "_")
alleles <- paste(vcf$REF, vcf$ALT, sep = "/")
chrom <- vcf$CHROM
pos <- vcf$POS
strand <- NA
assembly <- NA
center <- NA
protLSID <- NA
assayLSID <- NA
panelLSID <- NA
QCcode <- NA
genotype_df <- vcf[c(-1:-4)]


f1 <- function(x) gsub('/','',x)
f2 <- function(x) gsub('\\.\\.','NN',x)

temp <- data.frame(t(apply(vcf[c(-1:-4)],1,f1)))

genotype_df <- data.frame(t(apply(temp,1,f2)))

hapmap <- cbind(rs, alleles, chrom, pos, strand, assembly, center, protLSID, assayLSID, panelLSID, Qcode, genotype_df)


write.table(hapmap, opt$output, row.names=FALSE, quote=FALSE, sep="\t")











