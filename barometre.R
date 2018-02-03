# Ce script tente d'extraire des données pertinents des réponses aux deux questions
# ouvertes du baromètre des villes cyclables de la FUB, édition 2017
#
library(stringr)
library(dplyr)
# Lire les données
# l'argument 'ville' doit correspondre au nom du fichier à lire, sans le .csv
lire_donnees <- function (ville){
  nomfic <- paste(ville,".csv", sep="")
  data <- read.csv2(nomfic, stringsAsFactors = F)
}
#
# Fonction qui cherche des noms de rue dans un texte
trouve_rues <- function(texte, col){
  pattern_rue <- "([Rr]ue|[Aa]venue|[Bb]oulevard|[Pp]lace|[Rr]oute|[Pp]orte) ((de|des|du) )*((la|les|le) )*(.\')*((([Ff]aubourg)|([Gg][ée]n[ée]ral)) )*((([Ss]aint)|([Ss][Tt])|([Ss]ainte|[Ss]te))([:space:]|[:punct:]))*[:alpha:]+"
  rues <- str_extract_all(texte[,col],pattern_rue)
  as_tibble(str_to_lower(unlist(rues))) #met tout en minuscule pour homogénéiser
}

# Fonction qui cherche juste des mots de 4 lettres ou plus
trouve_mots <- function(texte, n, col){
  pattern_mot <- paste("[:alpha:]{",n,",}",sep="")
  mots <- str_extract_all(texte[,col],pattern_mot)
  as_tibble(str_to_lower(unlist(mots))) #met tout en minuscule pour homogénéiser
}

# Script - lecture des données, recherche des patterns
data_paris <- lire_donnees("Paris")
rues_paris <- trouve_rues(data_paris,2)
mots_paris <- trouve_mots(data_paris,5,3)
mots_rues_paris <- trouve_mots(data_paris,5,2)
# analyse des données extraites
count_rues_paris <- rues_paris %>% count(value) %>% arrange(desc(n))
count_mots_paris <- mots_paris %>% count(value) %>% arrange(desc(n))
count_mots_rues_paris <- mots_rues_paris %>% count(value) %>% arrange(desc(n))

#reste à faire: enlever les données vides ; vérifier la syntaxe du pattern de recherche; écrire les données
# dans un fichier lisible ; trouver les points noirs avec le plus grand nombre d'occurences
#write.csv2(rues_paris,file="rues.csv")
