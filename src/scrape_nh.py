#!/usr/bin/env python

import scrape_bulletin_nh
import scraper_commands
import db_load

home_dir = '/home/vaughn.hagerty/crime-scrapers/'
data_dir = home_dir + 'data_nh'
database = 'crime'
user = {'user': 'crimeloader','pw':'redaolemirc'}


def main():
    #fetch data from our google spreadsheet that tells us what to scrape
    sites_to_scrape = [{'URL': 'http://p2c.nhcgov.com/p2c/Summary.aspx','Agency':"New Hanover County Sheriff's Office",'County': 'New Hanover','How far back':'7'}]
    for site in sites_to_scrape:
        #variables we'll use in our scraping and data format
        county = site['County']
        url = site['URL']
        agency = site['Agency']
        #this is how many days back we want to scrape
        #e.g. 1 would scrape a total of 2 days:
        # today plus 1 day back (yesterday)
        howfar = int(site['How far back'])
        #try for daily bulletin
        #if not, then go for search
        bulletin_url = scrape_bulletin_nh.try_bulletin(url)
        data = scrape_bulletin_nh.start_scrape(agency, county, bulletin_url, howfar)
#        for record_type in data:
#            scraper_commands.all_data[record_type] = scraper_commands.all_data[record_type] + data[record_type]
    #output data as tab-delimited text files named for the
    #record type (arrest.txt, incident.txt, citation.txt, accident.txt)
    scraper_commands.print_files(scraper_commands.all_data,data_dir)
    for data_type in scraper_commands.all_data:
        data_file = data_dir + '/' + data_type + '.txt'
        table = data_type.lower() + 's'
        db_load.load(database,data_file, table, user)
if __name__ == "__main__":
    main()