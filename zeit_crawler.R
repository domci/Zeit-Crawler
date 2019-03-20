rm(list=ls())



library(XML)
library(httr)
library(rvest)
library(RCurl)




hrefs <- data.frame()


#issue <- 2

for(year in 2013:2015)  {#as.numeric(format(Sys.Date(), "%Y"))) {
  
  for(issue in 1:53) {
    
    issue <- as.character(ifelse(issue <= 9, paste0("0", issue), issue))
        
    url <- paste0("http://www.zeit.de/", year, "/", issue)
    response <- GET(url)
    
    response$status_code
    
    if (response$status_code == 200) {
      print(paste("Status:", response$status_code))
      print(paste("Issue:", issue, "/", year))

      doc <- content(response,type="text/html")
      tmp.hrefs <- data.frame(url=unlist(doc["//a[@id='YYYYYYhp.main.teaser.1.imageYYYY_ToDo']/@href"]))
      #tmp.hrefs <- data.frame(url=unlist(doc["//ul[@class='teaserlist']/li/a/@href"]))
      tmp.hrefs$title <- unlist(doc["//a[@id='YYYYYYhp.main.teaser.1.imageYYYY_ToDo']/@title"])
      
      #tmp.hrefs$title <- html_nodes(doc, xpath = "//h4[@class='title']") %>% html_text()
      tmp.hrefs$year <- year
      tmp.hrefs$issue <- issue
      hrefs <- rbind(hrefs, tmp.hrefs)
      Sys.sleep(0)
      
    } #else {
      #print(paste("Status:", response$status_code))
      #tmp.hrefs <- data.frame(url=response$status_code)
      #tmp.hrefs$title <- response$status_code
      #tmp.hrefs$year <- year
      #tmp.hrefs$issue <- issue
      #hrefs <- rbind(hrefs, tmp.hrefs)
      #year <- year + 1
    #}
    
  }
  
  
}
  


(table(hrefs$year, hrefs$issue))


hrefs$supertitle <- unlist(lapply(strsplit(hrefs$title, " - "), function (x) x[1]))



for (i in 1:nrow(hrefs)) {
  
  
}


i <- 1

article <- data.frame()

response <- GET(as.character(hrefs$url[i]))

response$status_code
doc <- content(response,type="text/html")

article[i,1] <- as.character(hrefs$url[i])
article[i,2] <- 
  
  
xx <- html_nodes(doc, xpath = "//span[@class='article-heading__kicker']/text()") %>% html_text()

xx <- gsub("[[:cntrl:]]", "", as.character(xx))

gsub(" ", "", as.character(xx))


?gsub
