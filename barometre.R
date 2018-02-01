# Ce script tente d'extraire des données pertinents des réponses aux deux questions
# ouvertes du baromètre des villes cyclables de la FUB, édition 2017
#
library(dplyr)
library(stringr)

# Lire les données
# l'argument 'ville' doit correspondre au nom du fichier à lire, sans le .csv
lire_donnees <- function (ville){
  nomfic <- paste(ville,".csv", sep="")
  data <- read.csv2(nomfic, stringsAsFactors = F)
}
#
#motscles <- c("rue","avenue","boulevard","place","route")
# Fonction qui cherche des noms de rue dans un texte
trouve_rues <- function(texte){
  pattern_rue <- "([Rr]ue|[Aa]venue|[Bb]oulevard|[Pp]lace|[Rr]oute) (de|du|des)? (la|le)? [a-zA-Zéèçàù]+"
  str_extract_all(texte[,2],pattern_rue)
}

# Scripts entier
data_paris <- lire_donnees("Paris")
rues_paris <- trouve_rues(data_paris)
#write.csv2(rues_paris,file="rues.csv")
