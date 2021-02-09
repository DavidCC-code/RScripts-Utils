library(leaflet)

my_map <- my_map %>%
  addMarkers(lat=41.3818, lng=2.1685,
              popup="Escola Milà i Fontanals")
my_map

## encuadre aproximado de barcelona con marcadores aleatorios
set.seed(2016-04-25)
df <- data.frame(lat = runif(100, min = 41.33, max = 41.4),
                 lng = runif(100, min = 2.14, max = 2.23))
df %>% 
  leaflet() %>%
  addTiles() %>%
  addMarkers()


## icone
##https://ajuntament.barcelona.cat/normativagrafica/imatges/BASE_B.jpg

BCNicon <- makeIcon(
  iconUrl = "https://ajuntament.barcelona.cat/normativagrafica/imatges/BASE_B.jpg",
  iconWidth = 15*215/230, iconHeight = 15,
  iconAnchorX = 31*215/230/2, iconAnchorY = 16
  )


## Descarrega dades de centres de serveis socials a barcelona de URL del opendata bcn
url <-"https://opendata-ajuntament.barcelona.cat/data/dataset/54e627e4-75ff-4420-bb7a-20826246753b/resource/dac689bb-a1de-4014-9aeb-d61fef01c6fb/download"
destFile <- "./CSS.csv"
download.file(url, destFile)

## llegeix csv
CSSBCN <- read.csv(destFile)


names(CSSBCN)[names(CSSBCN)=="LATITUD"] <- "lat"
names(CSSBCN)[names(CSSBCN)=="LONGITUD"] <- "lng"

CSSBCN %>% 
  leaflet() %>%
  addTiles() %>%
  addMarkers(icon = BCNicon , popup = paste(CSSBCN$EQUIPAMENT, "<br>", CSSBCN$TELEFON_NUM))

## Clusters  
##   - dades accidents de transit

url <- "https://opendata-ajuntament.barcelona.cat/data/dataset/834b8920-0685-4e16-8e20-faf13645f4f3/resource/4bf617c6-7fe0-4e6a-b010-1c6fef544a31/download/2019_accidents_tipus_gu_bcn_.csv"
destFile <- "./accidents2019.csv"
download.file(url, destFile)

ACC2019 <- read.csv(destFile)

names(ACC2019)[names(ACC2019)=="Latitud"] <- "latitude"
names(ACC2019)[names(ACC2019)=="Longitud"] <- "longitude"

ACC2019 %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(popup = ACC2019$Descripcio_tipus_accident)

