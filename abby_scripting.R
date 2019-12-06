library(phyloseq)
library(ggplot2)


calyx <- readRDS("calyx_end.RDS")
peel <- readRDS("peel.RDS")
apples <- readRDS("apples.RDS")
pulp <- readRDS("fruit_pulp.RDS")

apples_complete <- merge_phyloseq(apples, peel, pulp, calyx)

total = median(sample_sums(apples_complete))
standf = function(x, t=total) round(t*(x/sum(x)))
apples_normal <- transform_sample_counts(apples_complete, standf)

plot_bar(apples_normal, fill = "Phylum")
ord1 <- ordinate(apples_complete, method = "NMDS", distance = "bray")
p1 <- plot_ordination(apples_complete, ord1, color = "tissue", shape = "mngmt") + geom_point(size=5)
p1
