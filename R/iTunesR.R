#' Extract Reviews from iTunes App Store
#'
#' @param app_id A number Your iOS App ID for which reviews need to be downloaded
#' @param country A string country code like 'in' 'gb' for which reviews need to be downloaded
#' @param page_num A number page number from 1 to 10 with 1 being the most-recent
#' @return A Data frame of Reviews and meta information
#' @examples
#' extract_reviews(742044692,'in',1)



#' @export

extract_reviews <- function(app_id,country,page_num){



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


#reviews1 <- extract_reviews(app_id,1)
#reviews2 <- extract_reviews(app_id,2)
#reviews3 <- extract_reviews(app_id,3)
#reviews4 <- extract_reviews(app_id,4)

#reviews <- rbind(reviews1,reviews2,reviews3,reviews4)

