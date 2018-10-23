#Clustering DA2 downstream partners by morphology
#Compare initial 10% downstream sample to complete connectome

initial = catmaid_skids("FML - downstream of first DA2")
all = catmaid_skids("FML - downstream of DA2")

#Fetches all skids with the same annotation

new = all[!all%in%initial]

#Subtracts initial skids from all skids, giving skids not represented in the initial sample

initial_dp = fetchdp_fafb(initial)
new_dp = fetchdp_fafb(new)

#Fetches dot-props (NBLAST) for each skid

all_dp = c(initial_dp, new_dp)

DA2_matrix = nblast_allbyall(all_dp)

#NBLASTs each neurone against every other, returning an "interaction matrix"

DA2_matrix_clustered = nhclust(score = DA2_matrix)

#Carries out heirarchical clustering of DA2_matrix

plot(DA2_matrix_clustered, main = 'whole neurone morphology')

#Plots a dendrogram clustering neurones by morphology

#We would like to separate by colour initial from new

plot(colour_clusters(DA2_matrix_clustered, h = 6, col = rainbow))

plot(set_leaf_colours(as.dendrogram(DA2_matrix_clustered), "red", col_to_set = c("edge")))

