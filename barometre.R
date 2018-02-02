# Ce script tente d'extraire des données pertinents des réponses aux deux questions
# ouvertes du baromètre des villes cyclables de la FUB, édition 2017
#
library(stringr)

# Lire les données
# l'argument 'ville' doit correspondre au nom du fichier à lire, sans le .csv
lire_donnees <- function (ville){
  nomfic <- paste(ville,".csv", sep="")
  data <- read.csv2(nomfic, stringsAsFactors = F)
}
#
# Fonction qui cherche des noms de rue dans un texte
trouve_rues <- function(texte){
  pattern_rue <- "([Rr]ue|[Aa]venue|[Bb]oulevard|[Pp]lace|[Rr]oute) (de|du|des)? (la|le)? [:alpha:]+"
  str_extract_all(texte[,2],pattern_rue)
}

# Fonction qui cherche juste des mots de 4 lettres ou plus
trouve_mots <- function(texte){
  pattern_mot <- "
}

# Script
data_paris <- lire_donnees("Paris")
rues_paris <- trouve_rues(data_paris)

#reste à faire: enlever les données vides ; vérifier la syntaxe du pattern de recherche; écrire les données
# dans un fichier lisible ; trouver les points noirs avec le plus grand nombre d'occurences
#write.csv2(rues_paris,file="rues.csv")
