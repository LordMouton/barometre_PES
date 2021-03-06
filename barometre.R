# Ce script tente d'extraire des donn�es pertinents des r�ponses aux deux questions
# ouvertes du barom�tre des villes cyclables de la FUB, �dition 2017
#
library(stringr)
library(dplyr)
# Lire les donn�es
# l'argument 'ville' doit correspondre au nom du fichier � lire, sans le .csv
lire_donnees <- function (ville){
  nomfic <- paste(ville,".csv", sep="")
  data <- read.csv2(nomfic, stringsAsFactors = F)
}
#
# Fonction qui cherche des noms de rue dans un texte
trouve_rues <- function(texte, col){
  pattern_rue <- "([Rr]ue|[Aa]venue|[Bb]oulevard|[Pp]lace|[Rr]oute|[Pp]orte) ((de|des|du) )*((la|les|le) )*(.\')*((([Ff]aubourg)|([Gg][�e]n[�e]ral)) )*((([Ss]aint)|([Ss][Tt])|([Ss]ainte|[Ss]te))([:space:]|[:punct:]))*[:alpha:]+"
  rues <- str_extract_all(texte[,col],pattern_rue)
  as_tibble(str_to_lower(unlist(rues))) #met tout en minuscule pour homog�n�iser
}

# Fonction qui cherche juste des mots de 4 lettres ou plus
trouve_mots <- function(texte, n, col){
  pattern_mot <- paste("[:alpha:]{",n,",}",sep="")
  mots <- str_extract_all(texte[,col],pattern_mot)
  as_tibble(str_to_lower(unlist(mots))) #met tout en minuscule pour homog�n�iser
}

# Script - lecture des donn�es, recherche des patterns
data_paris <- lire_donnees("Paris")
rues_paris <- trouve_rues(data_paris,2)
mots_paris <- trouve_mots(data_paris,5,3)
mots_rues_paris <- trouve_mots(data_paris,5,2)
# analyse des donn�es extraites
count_rues_paris <- rues_paris %>% count(value) %>% arrange(desc(n))
count_mots_paris <- mots_paris %>% count(value) %>% arrange(desc(n))
count_mots_rues_paris <- mots_rues_paris %>% count(value) %>% arrange(desc(n))

#reste � faire: enlever les donn�es vides ; v�rifier la syntaxe du pattern de recherche; �crire les donn�es
# dans un fichier lisible ; trouver les points noirs avec le plus grand nombre d'occurences

# Ecrire les r�sultats dans des fichiers
write.csv2(count_rues_paris,"count_rues_paris.csv")
write.csv2(count_mots_rues_paris, "count_mots_rues_paris.csv")
write.csv2(count_mots_paris, "count_mots_paris.csv")
