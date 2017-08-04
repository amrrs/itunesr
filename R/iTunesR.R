#' Extract Reviews from iTunes App Store
#'
#' @param app_id A number Your iOS App ID for which reviews need to be downloaded
#' @param country A string country code like 'in' 'gb' for which reviews need to be downloaded
#' @param page_num A number page number from 1 to 10 with 1 being the most-recent
#' @return A Data frame of Reviews and meta information
#' @examples
#' getReviews(742044692,'in',1)


#' @export

getReviews <- function(app_id,country,page_num){



        #building_url


        json_url <- paste0('http://itunes.apple.com/',country,'/rss/customerreviews/page=',page_num,'/id=',app_id,'/sortby=mostrecent/','json')

        xml_url <- paste0('http://itunes.apple.com/',country,'/rss/customerreviews/page=',page_num,'/id=',app_id,'/sortby=mostrecent/','xml')


        js <- jsonlite::fromJSON(json_url)

        reviews <- cbind(Title = js$feed$entry$title$label,Author_URL = js$feed$entry$author$uri,Author_Name = js$feed$entry$author$name,App_Version = js$feed$entry$`im:version`$label,Rating = js$feed$entry$`im:rating`$label,Review = js$feed$entry$content$label)

        reviews <- reviews[-1,]

        names(reviews) <- c('Title','Author_URL','Author_Name','App_Version','Rating','Review')

        #reading xml for date

        #xml_url <- 'http://itunes.apple.com/gb/rss/customerreviews/id=370901726/sortBy=mostRecent/xml'

        xml_n <- xml2::read_xml(xml_url)


        entries <- xml2::xml_children(xml_n)[xml2::xml_name(xml2::xml_children(xml_n))=='entry']

        entries <- entries[-1]

        #extrcting date from entries

        date <- xml2::xml_text(xml2::xml_children(entries))[xml2::xml_name(xml2::xml_children(entries))=='updated']

        reviews$Date <- lubridate::with_tz(strptime(date,format='%Y-%m-%dT%H:%M:%S',tz='America/Los_Angeles'),tzone='Europe/London')

        #re-arraning column order

        #reviews <- reviews[,c(7,4,5,1,6,3,2)]

        return(reviews)

}

#' Download App Logo from iTunes App Store
#'
#' @param app_id A number Your iOS App ID for which reviews need to be downloaded
#' @param country A string country code like 'in' 'gb' for which reviews need to be downloaded
#' @return downloads and saves App Logo in the current working directory
#' @examples
#' getLogo(742044692,'in')


#' @export

getLogo <- function(app_id,country){

  page_num = 1

  json_url <- paste0('http://itunes.apple.com/',country,'/rss/customerreviews/page=',page_num,'/id=',app_id,'/sortby=mostrecent/','json')

  js <- jsonlite::fromJSON(json_url)

  download.file(js$feed$entry$`im:image`[[1]]$label[3],paste0(app_id,'_logo.png'),mode='wb')

}

#' Get Basic App Attributes from iTunes App Store
#'
#' @param app_id A number Your iOS App ID for which reviews need to be downloaded
#' @param country A string country code like 'in' 'gb' for which reviews need to be downloaded
#' @return A Data frame of App Attributes containing Title, Developer, Package Name, URL, Category
#' @examples
#' getAttributes(742044692,'in')


#' @export
#' @importFrom utils download.file



getAttributes <- function(app_id,country){

  page_num = 1

  json_url <- paste0('http://itunes.apple.com/gb/rss/customerreviews/page=',page_num,'/id=',app_id,'/sortby=mostrecent/','json')

  js <- jsonlite::fromJSON(json_url)

  app_attributes <- data.frame(t(c(js$feed$entry$`im:name`$label[1],js$feed$entry$`im:artist`$label[1],js$feed$entry$id$attributes$`im:bundleId`[1],js$feed$entry$id$label[1],js$feed$entry$category$attributes$label[1])))

  colnames(app_attributes) <- c('Title','Developer','Package','URL','Category')

  return(app_attributes)

}
