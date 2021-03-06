#Ce script recherche les rues trouv�es ici http://www.v2asp.paris.fr/commun/v2asp/v2/nomenclature_voies/Voieactu/index.nom.htm
# dans le fichier de r�ponses aux questions ouvertes
# D�faut : il faut la strucutre compl�te
# Par ex, la r�ponse "Boulevard Magenta" ne sera pas comptabilis�e car dans la liste des rues, il est �crit "boulevard DE Magenta"


data_paris <- read.csv2("Paris.csv", stringsAsFactors = F, header = T)
data_paris_tbl <- as_tibble(data_paris)

liste_rues <- read.csv("liste_rues_paris.csv",stringsAsFactors = F, encoding= "UTF-8", header=F)
liste_rues_clean <- str_replace(liste_rues[,1],"-"," ")
rues_tbl <- as_tibble(liste_rues_clean)

data_paris_tbl <- mutate(data_paris_tbl,lower_pt_noir=str_to_lower(Q0_Ouv_point_noir))

rues_count <- rues_tbl %>%
  mutate(lower = str_to_lower(value)) %>%
  mutate(count= str_count(string=data_paris_tbl[,4],pattern = lower)) %>%
  arrange(desc(count))

write.csv2(rues_count,"comp_liste_rues.csv")
