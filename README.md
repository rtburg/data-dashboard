Open N.C. Data Dashboard
=====================

The [Data Dashboard](http://data.open-nc.org/wake/) is a system to scrape, load and process public data such as crime reports or tax records and make them available for search and analysis. It was built to be a tool to help journalists search for stories in public data. The dashboard includes features to send email alerts to specific users when data matching their search criteria is added to the database and a simple "widget maker" to create embeddable data tables and graphs based on search results.

This project was funded by the Knight Foundation, Google and UNC-Chapel Hill, which oversaw its development. Ryan Thornburg, a journalism professor at UNC-Chapel Hill, managed development. Vaughn Hagerty, an independent data journalist and developer, was lead developer on the project.

The Data Dashboard is an open-source project. You are free to make copies of any files in the project, as long as you credit [Open N.C.](https://open-nc.org/) It is offered as-is, with no guarantees or technical support.

Note: This is *not* a push-button, set-it-and-forget-it system. You'll likely struggle unless you have a decent amount of experience with some flavor of Linux, Python and JavaScript. Once it is set up, it should function on its own for the most part. Depending on the data you add, however, you'll likely need to commit to about a dozen hours a month in monitoring and maintenance.

You'll also need access to web-facing servers. The original Data Dashboard ran on three servers running Debian linux (one for scraping, one for the user-facing portion and search scripts, and a third for the search database). Theoretically, it could run on a single server, though searches and other functionality likely would be slow. In addition, you'll need a decent amount of disk space, especially if you store items such as report PDFs.

We used Google Compute Cloud as our server platform, though AWS would work fine as well. Other offerings may work, but you'll likely have difficulty unless you have ssh access to your servers and the ability to install software such as Python modules.

In this repo are scripts to ingest the data we were gathering. That includes scrapers that can be adapted for *most* OSSI-based (p2c) crime report systems. In addition, there are scripts to load data from the Raleigh Police Department, N.C. voter registration data, Buncombe County property tax records and real estate transactions, and health inspections (restaurant grades) from North Carolina. You're free to use these as you wish, but keep in mind that agency systems may change over time, causing these scripts to break. You'll need to write or acquire any other programming necessary for any additional data you'd like to include.

System overview and setup
--------------------------------

####Data ingestion

**Scraping and processing data:** Processing may include any formatting and standardization of the data as well as possible geocoding. Scripts for this include (see inline documentation on individual scripts for more detailed information): 	 	

 - scrapers/scrape.py: The main scraper script for OSSI-based scrapers.
   Note that we also include a few custom scripts to handle sites for
   which the source customization is such that separate programming was
   needed (scrape_nh.py, scrape_fay.py)
 - scrapers/geocode/geocode_goog.py: Used to geocode crime data.
 - scrapers/nh_voters/load_voters.txt: Command-line calls used to load voter registration data.    
 - scrapers/health/health_inspections.py: Load    health inspections
   data from the state.
 - scrapers/buncombe_property/dl_buncombe_property.txt: Command-line calls to download Buncombe County property tax and real estate transactions data.

	
####The user-facing Data Dashboard

**Search database:** Depending on the size of your data and the anticipated number of searches -- as well as the latency you're willing to tolerate -- you should consider placing this on a separate server with as much processing power, memory and storage space as you can afford. This is likely to be the biggest bottleneck in the dashboard.
		
**Front end:** The dashboard was developed to show data for one, specific county. That means that you'll need to have separate dashboards for each county for which you wish to display data. The files for the dashboard includes the HTML, CSS, JavaScript, images and Handlebars templates that make up the web app. These include:

- dashboard/front_end/html/index.html: Start page for a county-specific dashboard. Shows graphs and tables for the last 30 days' worth of  data for each data category.
- dashboard/front_end/html/buncombe (or wake or new-hanover): examples of the JSON files that contain data to display the 30-day stats  (generated by dashboard/stats/stats.py)
- dashboard/front_end/html/lib: css, images, JavaScript and Handlebars.js templates. See inline documentation on js files for more detailed information on their functionality.
- dashboard/front_end/html/search: index.html is the "frame" of html used by each of the searches. There are form.html files for each type of search (arrests, etc.) as well as for the main search that searches all data. These are inserted into index.html, depending on the type of search the user is conducting.
		
**The search and alerts back end:** These are Python scripts. There is a Flask app that searches the database and returns JSON responses and also allows the user to manage any data alerts. We had this set up as a WSGI service. A second Python script generates the initial dashboard page -- a 30-day snapshot of certain data points (crime by category or day of week, top real estate transactions, etc.) over the most recent 30 days. Another script searches the database based on the alert criteria and sends emails for any results. Scripts *as always, see inline documentation for more detailed information) include:
		
- dashboard/stats/stats.py: Generates JSON files for 30-days snapshot.
- dashboard/search/search.py: Flask app to handle user requests from dashboard, including search and alert management (add, delete, pause). Returns JSON.
- dashboard/alerts/dash-alerts.py: Looks for new data based on alert parameters and emails users anything it finds. We used SendGrid as our email provider. We also used Jinja2 to format emails. Templates are in: dashboard/alerts/jinja-templates
		
Setup overview
------------------
###Dependencies
	Python, plus these modules:
		Requests
		BeautifulSoup
		MySQLdb
		slugify
		sendgrid (for email alerts)
		jinja2 (for email alerts)


	JavaScript/HTML/CSS:
		jQuery
		Bootstrap
		Handlebars
		Google visualization
	
	MySQL
	
The following is a high-level summary of the setup process. You'll need to adapt this outline to your own situation, depending on factors such as your server infrastructure and data you are scraping.
	
**Database:** The original dashboard used two databases containing the same tables. The first one was used to hold data being loaded by the scrapers. Because of the volume of inserts and updates, it had very few indexes. The second database was used for user searches. It was fed by the first one and included several indexes. The system can run on a single database but it may be slower for the user.
		
There are several sql scripts in the create_tables_sql directory that may be used to create the table structure for the first database. Each table is in a separate sql file to allow you to pick and choose which data types you want to include. In addition, there are sql scripts to create the search database indexes in create_tables_sql/indexes.
		
Our dashboard included four database users:
		
- Admin: Just what it says with all privileges.
- Scraper and formatter: This user had read, write, update and delete privileges on all tables. It was never user facing.
- Search user: This user had read-only access to the data files.
- User management: Read, write, update access on tables used to manage user email alerts.
		
###Scrapers
Create a directory for your scraper scripts. In that directory create the following directories: pdfs, data, logs. If you are running the scrapers for Fayetteville PD and New Hanover County SO, create data_fay and data_nh. IMPORTANT: The pdfs directory can get fairly large, fairly fast. Be sure you've allocated enough space and check it regularly.
		
For crime data, examine scrapers/scraper_config/config.py. You'll find spots for you to add information about the database, as for server paths to reflect your directory structure. Examine scrapers/scraper.py for more specific setup information on how to use it to scrape specific sites.
		
You'll also find server paths in the scripts for voter data, health inspections and Buncombe County property data. Update those to reflect your setup.
		
Be sure to see the list of Python dependencies above and install those modules.
		
###Dashboard
		
**Back end:** This includes dashboard/search, dashboard/stats, and dashboard/alerts. See the config files for each of these for directory structures, database configuration and other items you may need to update for your particular setup.
			
Stats and alerts scripts were run once a day on the original dashboard. The search script was a Flask app that ran as a WSGI service.
			
**Front end:** These files (dashboard/front_end/html) should go somewhere in your web server root directory. Note that if you are hosting a dashboard for more than one county, you may want to have a master directory somewhere and use symbolic links to create the directories for your user. This can make rolling out updates much easier, since you only have to change the master file(s).
			

> **IMPORTANT:** When you set up the files in dashboard/front_end/html, put  each county's files in a directory named after the county -- lowercased with hyphens instead of any spaces and only the name, not the county. For example, on our dashboard, New Hanover county was at data.open-nc.org/new-hanover. The script uses this to determine which county is being searched so that it can restrict any sql queries to data for that county.

