import re
import datetime
import hashlib

import scraper_commands
import date_formatters
import store_pdf
import scrape_logs
import requests
from bs4 import BeautifulSoup


# disclaimer_items = {'_popupBlockerExists': 'true', '__EVENTTARGET': '', '__EVENTARGUMENT': '', '__LASTFOCUS': '',
# 'ctl00$MasterPage$DDLSiteMap1$ddlQuickLinks': '~/main.aspx',
# 'ctl00$MasterPage$mainContent$CenterColumnContent$btnContinue': 'I Agree'}

# search_items = {'__EVENTTARGET': 'MasterPage$mainContent$cmdSubmit2', '__EVENTARGUMENT': '', '__LASTFOCUS': '',
# 'MasterPage$DDLSiteMap1$ddlQuickLinks': '~/main.aspx', 'MasterPage$mainContent$txtCase2': '',
# 'MasterPage$mainContent$rblSearchDateToUse2': 'Date Reported',
# 'MasterPage$mainContent$ddlDates2': 'Specify Date', 'MasterPage$mainContent$txtLName2': '',
# 'MasterPage$mainContent$txtFName2': '', 'MasterPage$mainContent$txtMName2': '',
# 'MasterPage$mainContent$txtStreetNo2': '', 'MasterPage$mainContent$txtStreetName2': '',
# 'MasterPage$mainContent$ddlNeighbor2': '', 'MasterPage$mainContent$ddlRange2': '',
# 'MasterPage$mainContent$addresslat': '', 'MasterPage$mainContent$addresslng': '','MasterPage$mainContent$txtDateFrom2': '', 'MasterPage$mainContent$txtDateTo2': ''}

main_url = ''

s = requests.Session()

#make an array of formatted dates we'll use to grab
#each of the bulletin pages

#should probably rename this and the next function
#this one grabs the record type (arrest, incident, etc.)
# and, if available, the record id
def parse_id_and_type(piece):
    record_types = {'LW': 'Incident', 'AR': 'Arrest', 'TA': 'Accident', 'TC': 'Citation', 'OR': 'Citation'}
    items = piece.text.split(" ")
    record_type = record_types[items[0]]
    if record_type == 'Accident':
        record_id = items.pop()
    else:
        record_id = piece.find('br').previous_sibling.split(" ").pop()
    return {'record_id': record_id, 'record_type': record_type}

#this one decides what parsing function to call based on record type.
#piece is the beautifulsoup table row that contains our data
#id_and_type is a dict with those items
#officer is a dict with the reporting officer

def parse_details(piece, id_and_type, officer):
    if id_and_type['record_type'] == 'Incident':
        data = parse_incident(piece, id_and_type, officer)
    elif id_and_type['record_type'] == 'Arrest':
        data = parse_arrest(piece, id_and_type, officer)
    elif id_and_type['record_type'] == 'Citation':
        data = parse_citation(piece, id_and_type, officer)
    else:
        data = parse_accident(piece, id_and_type, officer)
    #data contains a dict with the items we pulled and formatted
    #we append that to the record_type array in all data
    #build a single all_data to print later
    if data is None:
        return
    return scraper_commands.all_data[id_and_type['record_type']].append(scraper_commands.check_data(data))

#each of the following four functions parse specific record types

def parse_incident(piece, id_and_type, officer):
    other_data = {'scrape_type': 'bulletin', 'id_generate': '0'}
    m = re.compile(
        '(?P<name>.*) *\((?P<rsa>.*)\) ?VICTIM of (?P<charge>[^.]+) \((?P<offense_code>[A-Z ])\), '
        'at (?P<address>.+), +(?P<on_or_between>between|on) (?P<occurred_date>[^\.]+)\. Reported: '
        '(?P<reported_date>[^\.]+)\.')
    matches = m.search(piece.text)
    if not matches:
        m = re.compile(
            '(?P<name>.*) VICTIM of (?P<charge>.+) \((?P<offense_code>[A-Z ])\), at (?P<address>.+),'
            ' +(?P<on_or_between>between|on) (?P<occurred_date>[^\.]+)\. Reported: (?P<reported_date>[^\.]+)\.')
        matches = m.search(piece.text)
    if not matches:
        log_parse_issue(piece,id_and_type)
        return
    data = matches.groupdict()
    data = race_sex_age(data)
    data = date_formatters.on_between(data)
    if data['reported_date'].find(':') == -1:
        data['reported_date'] = date_formatters.format_db_date(data['reported_date'])
        data['date_reported'] = data['reported_date']
        data['time_reported'] = ''
    else:
        data['date_reported'] = date_formatters.format_db_date_part(data['reported_date'])
        data['time_reported'] = date_formatters.format_db_time_part(data['reported_date'])
        data = date_formatters.format_reported_date(data, 'reported_date')
    data['pdf'] = find_pdf(data, id_and_type)

    return dict(data.items() + officer.items() + id_and_type.items() + other_data.items())


def parse_arrest(piece, id_and_type, officer):
    other_data = {'scrape_type': 'bulletin', 'id_generate': '0'}
    m = re.compile('(?P<name>[^()]+) Arrest on chrg of (?P<charge>[^(]+) \(*?P<offense_code>[A-Za-z]?\)?'
                   ' ?\(?(?P<other_code>.?)\)?, at (?P<address>.+), +on +(?P<occurred_date>[^\.]+)\.')
    matches = m.search(piece.text)
    if matches:
        matches = matches
    else:
        m = re.compile('(?P<name>.+) \((?P<rsa>.*)\) Arrest on chrg of (?P<charge>[^(]+) '
                       '\(?(?P<offense_code>[A-Za-z]?)\)? ?\(?(?P<other_offense_code>.?)\)?, '
                       'at (?P<address>.+), +on +(?P<occurred_date>.+)\.')
        matches = m.search(piece.text)
        if not matches:
            m = re.compile('(?P<name>.+) \((?P<rsa>.*)\) Arrest on chrg of (?P<charge>[^(]+) '
                           '\(?(?P<offense_code>[A-Za-z]?)\)? ?\(?(?P<other_offense_code>.?)\)?, '
                           '.+, +on +(?P<occurred_date>[^\.]+)\.')
            matches = m.search(piece.text)
        # skip this one if there's not enough info
        if not matches:
            log_parse_issue(piece,id_and_type)
            return
    data = matches.groupdict()
    data = race_sex_age(data)
    if id_and_type['record_id'] is None or id_and_type['record_id'] == '':
        other_data['id_generate'] = "1"
        if 'address' not in data:
            data['address'] = ''
#        id_and_type['record_id'] = hashlib.sha224( + matches[0][2] + matches[0][3] + matches[0][4] + matches[0][5]) \
        id_and_type['record_id'] = hashlib.sha224(data['name'] + data['occurred_date'] + data['address']
             + data['charge']).hexdigest()
    else:
        data['date_reported'] = date_formatters.format_db_date(data['occurred_date'].split(' ')[0])
        data['pdf'] = find_pdf(data, id_and_type)

    data = date_formatters.format_date_time(data, 'occurred_date')
    return dict(data.items() + officer.items() + id_and_type.items() + other_data.items())


def parse_citation(piece, id_and_type, officer):
    other_data = {'scrape_type': 'bulletin', 'id_generate': '0'}
    m = re.compile(
        '(?P<name>.+) \((?P<rsa>.*)\) Cited on Charge of (?P<charge>.+), at (?P<address>.+), +'
        'on +(?P<occurred_date>.+)\.')
    matches = m.search(piece.text)
    if not matches:
        m = re.compile('(?P<name>.+) \((?P<rsa>.*)\) Cited on Charge of (?P<charge>.+)')
        matches = m.search(piece.text)
    if not matches:
        log_parse_issue(piece,id_and_type)
        return
    data = matches.groupdict()
    data = race_sex_age(data)
    data = date_formatters.format_date_time(data, 'occurred_date')
    return dict(data.items() + officer.items() + id_and_type.items() + other_data.items())


def parse_accident(piece, id_and_type, officer):
    other_data = {'scrape_type': 'bulletin', 'id_generate': '0'}
    m = re.compile('On (?P<occurred_date>.+) at (.*), an accident occured on'
                   ' +(?P<address>[^\.]+)\..+Accident involving: (?P<names>.+)')
    matches = m.search(piece.text)
    if not matches:
        log_parse_issue(piece,id_and_type)
        return
    data = matches.groupdict()
    # names might be more than one
    data = people_in_accident(data)
    data = date_formatters.format_date_time(data, 'occurred_date')
    if id_and_type['record_id'] is None or id_and_type['record_id'] == '':
        other_data['id_generate'] = "1"
        if 'address' not in data:
            data['address'] = ''
        id_and_type['record_id'] = hashlib.sha224(data['names'] + data['occurred_date'] + data['address']).hexdigest()
    else:
        data['date_reported'] = date_formatters.format_db_date(data['occurred_date'].split(' ')[0])
        data['pdf'] = find_pdf(data,id_and_type)
    return dict(data.items() + officer.items() + id_and_type.items() + other_data.items())


def race_sex_age(data):
    rsa = {'race': '', 'sex': '', 'age': ''}
    if 'rsa' in data and data['rsa'] != '':
        m = re.compile('(?P<race>[A-Z])[ /]*(?P<sex>[A-Z])[,/ ]*(?P<age>\d+)');
        matches = m.search(data['rsa'])
        if matches:
            rsa = matches.groupdict()
#        pieces = data['rsa'].split('/')
#        pieces[0] = pieces[0].strip()
#        rsa = {'race': pieces[0], 'sex': pieces[1], 'age': pieces[2]}
    return dict(data.items() + rsa.items())


def people_in_accident(data):
    names = {'name1': '', 'name2': ''}
    people = data['names'].split(', ')
    for i in range(len(people)):
        if i < 2:
            key = 'name' + str(i + 1)
            names[key] = people[i]
    return dict(data.items() + names.items())


def find_pdf(data,id_and_type):
#    print id_and_type
    global main_url
    if main_url == '':
        return ''
    try:
        page = s.get(main_url)
    except requests.exceptions.ConnectionError as e:
        log_pdf_scrape_issue(id_and_type)
        return ''
    soup = BeautifulSoup(page.text)
    payload = extract_form_fields(soup)
    types = {'Arrest':'AR','Accident':'TA','Incident':'LW','Citation':'TC'}
    this_type = types[id_and_type['record_type']]
#try to figure out what version it is
    if 'MasterPage$mainContent$txtDateFrom2' in payload:
        payload['MasterPage$mainContent$txtDateFrom2'] = payload['MasterPage$mainContent$txtDateTo2'] = date_formatters.format_search_date(data['date_reported'])
        payload['MasterPage$mainContent$txtCase2'] = id_and_type['record_id']
        payload['MasterPage$mainContent$rblSearchDateToUse2'] = 'Date Reported'
        payload['__EVENTTARGET'] = 'MasterPage$mainContent$cmdSubmit2'
    if 'ctl00$mainContent$txtDateFrom2' in payload:
        payload['ctl00$mainContent$txtDateFrom2'] = payload['ctl00$mainContent$txtDateTo2'] = date_formatters.format_search_date(data['date_reported'])
        if 'ct100$mainContent$btnReset' in payload:
            del payload['ct199$mainContent$btnReset']
        if 'MasterPage$DDLSiteMap1$ddlQuickLinks' in payload and payload['MasterPage$DDLSiteMap1$ddlQuickLinks'] == '':
            del payload['MasterPage$DDLSiteMap1$ddlQuickLinks']
        payload['ctl00$mainContent$txtCase2'] = id_and_type['record_id']
        payload['ctl00$mainContent$rblSearchDateToUse2'] = 'Date Reported'
        payload['__EVENTTARGET'] = 'ctl00$mainContent$cmdSubmit2'
    if 'MasterPage$mainContent$txtDateFrom$txtDatePicker' in payload:
        payload['MasterPage$mainContent$txtDateFrom$txtDatePicker'] = payload['MasterPage$mainContent$txtDateTo$txtDatePicker'] = date_formatters.format_search_date(data['date_reported'])
        if 'MasterPage$mainContent$btnReset' in payload:
            del payload['MasterPage$mainContent$btnReset']
        if 'MasterPage$DDLSiteMap1$ddlQuickLinks' in payload and payload['MasterPage$DDLSiteMap1$ddlQuickLinks'] == '':
            del payload['MasterPage$DDLSiteMap1$ddlQuickLinks']
        payload['MasterPage$mainContent$txtCase'] = id_and_type['record_id']
        payload['MasterPage$mainContent$rblSearchDateToUse'] = 'Date Reported'
        payload['__EVENTTARGET'] = 'Search'
    if 'ctl00$mainContent$txtDateFrom$txtDatePicker' in payload:
        payload['ctl00$mainContent$txtDateFrom$txtDatePicker'] = payload['ctl00$mainContent$txtDateTo$txtDatePicker'] = date_formatters.format_search_date(data['date_reported'])
        if 'ctl00$mainContent$btnReset' in payload:
            del payload['ctl00$mainContent$btnReset']
        payload['ctl00$mainContent$txtCase'] = id_and_type['record_id']
        payload['ctl00$mainContent$rblSearchDateToUse'] = 'Date Reported'
        payload['ctl00$mainContent$cmdSubmit'] = 'Search'
        payload['__EVENTTARGET'] = ''
        payload['__EVENTARGUMENT'] = ''
        payload['__LASTFOCUS'] = ''
#check to see if our type is available. if it is, only
#only search for that type. incidents and arrests on the same event
#sometimes have the same case number
    found_type = False
    check_payload = dict(payload.items())
    for key, value in check_payload.iteritems():
        if value == 'on':
            if key.find(this_type) != -1:
                found_type = True
            else:
                del payload[key]
#the type of record we're searching for isn't available
#via aearch
    if not found_type:
        return ''
    referer = {'Referer': main_url}
    try:
        page = s.post(main_url, data=payload, headers=referer)
    except requests.exceptions.ConnectionError as e:
        return ''
    soup = BeautifulSoup(page.text)
    records = soup.find_all('tr', {"class":'EventSearchGridRow'})
    payload = extract_form_fields(soup)
    # v = soup.find('input', {'id': "__VIEWSTATE"})['value']
    # e = soup.find('input', {'id': "__EVENTVALIDATION"})['value']
    # v_e = {'__VIEWSTATE': v, '__EVENTVALIDATION': e}
#we should only have one. if not, something's wrong
    if not records or len(records) > 1:
        return ''
    for record in records:
        record_fields = record.find_all('td',attrs={'class':None})
        has_gif = record_fields[5].find('a').find('div')
        if has_gif is None:
            #there's no pdf
            return ''
        report = record_fields[5].find('a')['href']
        if report is not None:
            m = re.compile(r"'(?P<first>[^']*)','(?P<second>[^']*)'")
            matches = m.search(report)
            data = matches.groupdict()
            target = data['first']
            argument = data['second']
#            return dl_pdf(record_fields[5].find('a')['href'].strip().split("'")[1], id_and_type, payload, main_url)
            return dl_pdf(target, argument, id_and_type, payload, main_url)


def dl_pdf(target, argument, id_and_type, payload, url):
#    print target
    if target == '' or target is None:
        return ''
    pdf_file = store_pdf.create_file_name(id_and_type['record_id'],id_and_type['record_type'],id_and_type['agency'])
    if store_pdf.file_exists(pdf_file):
        return pdf_file
    # pdf_search_items = dict(search_items.items())
    # pdf_search_items['__EVENTTARGET'] = target
    # pdf_search_items['__EVENTARGUMENT'] = ''
    # payload = dict(pdf_search_items.items() + v_e.items())
    payload['__EVENTTARGET'] = target
    if 'ctl00$mainContent$btnReset' in payload:
        del payload['ctl00$mainContent$btnReset']
    if 'ctl00$mainContent$cmdSubmit' in payload:
        del payload['ctl00$mainContent$cmdSubmit']
    if argument != '':
        payload['__EVENTARGUMENT'] = argument
    referer = {'Referer': url}
    pdf_response = s.post(url, data=payload, headers=referer, allow_redirects=True, stream=True)
    pdf_file = store_pdf.store_file(pdf_response,pdf_file)
    return pdf_file


def log_parse_issue(this_piece,this_id_and_type):
    log_msg = 'Failed to match ' + " / ".join(this_id_and_type.values())
    scrape_logs.log(this_id_and_type['agency'],log_msg)


def log_unreachable(url):
    scrape_logs.log('See URL',url)


def log_pdf_scrape_issue(this_id_and_type):
    log_msg = 'PDF url failed for ' + " / ".join(this_id_and_type.values())
    scrape_logs.log(this_id_and_type['agency'],log_msg)

def pass_disclaimer(url):
#    print "Passing disclaimer"
    page = s.get(url)
    if page.url != url:
        disclaimer_url = page.url
        soup = BeautifulSoup(page.text)
        payload = extract_form_fields(soup)
        referer = {'Referer': disclaimer_url}
        page = s.post(disclaimer_url, data=payload, headers=referer)
#        types_available(page)



def types_available(page):
    global search_items
    soup = BeautifulSoup(page.text)
    checkboxes = soup.find_all('input', {'type': 'checkbox'})
    for checkbox in checkboxes:
        search_items[checkbox['name']] = 'on'


def extract_form_fields(soup):
    fields = {}
    for input in soup.findAll('input'):
        # ignore submit/image with no name attribute
        if input['type'] in ('submit', 'image') and not input.has_attr('name'):
            continue
        
        # single element nome/value fields
        if input['type'] in ('text', 'hidden', 'password', 'submit', 'image'):
            value = ''
            if input.has_attr('value'):
                value = input['value']
            fields[input['name']] = value
            continue
        
        # checkboxes and radios
        if input['type'] in ('checkbox', 'radio'):
            value = ''
            if input.has_attr('checked'):
                if input.has_attr('value'):
                    value = input['value']
                else:
                    value = 'on'
            if fields.has_key(input['name']) and value:
                fields[input['name']] = value
            
            if not fields.has_key(input['name']):
                fields[input['name']] = value
            
            continue
        
        assert False, 'input type %s not supported' % input['type']
    
    # textareas
    for textarea in soup.findAll('textarea'):
        fields[textarea['name']] = textarea.string or ''
    
    # select fields
    for select in soup.findAll('select'):
        value = ''
        options = select.findAll('option')
        is_multiple = select.has_attr('multiple')
        selected_options = [
            option for option in options
            if option.has_attr('selected')
        ]
        
        # If no select options, go with the first one
        if not selected_options and options:
            selected_options = [options[0]]
        
        if not is_multiple:
            assert(len(selected_options) < 2)
            if len(selected_options) == 1:
                value = selected_options[0]['value']
        else:
            value = [option['value'] for option in selected_options]
        
        fields[select['name']] = value
    
    return fields

def find_v_e(page):
    soup = BeautifulSoup(page)
    v = soup.find('input', {'id': "__VIEWSTATE"})['value']
    e = soup.find('input', {'id': "__EVENTVALIDATION"})['value']
    return {'__VIEWSTATE': v, '__EVENTVALIDATION': e}


def try_bulletin(url):
    global main_url
    main_url = url
    if url.find('Summary') != -1:
        bulletin_url = re.sub('Summary', 'dailybulletin', url)
    else:
         bulletin_url = url
         main_url = ''
    try:
        page = requests.get(bulletin_url)
    except requests.exceptions.ConnectionError as e:
        log_unreachable(bulletin_url)
        return 'unreachable'
    if page.url != bulletin_url:
        return False
    pass_disclaimer(url)
    return bulletin_url


def start_scrape(agency, county, url, howfar):
    """

    :param url: The url to the daily bulletin
    :param howfar: How many days back to scrape
    """
    print_url = re.sub('dailybulletin', 'DailyBulletinPrint', url)
    s.get(url)
    dates = date_formatters.make_dates(howfar)
    for date in dates:
        payload = {'Date': date, 'Type': 'AL'}
        referer = {'Referer': url}
        page = s.get(print_url, params=payload, headers=referer)
	soup = BeautifulSoup(page.text.encode('utf-8'))
        count = 0
        for row in soup.find_all('table', id="dgBulletin")[0].find_all('tr'):
            if count == 0:
                count += 1
            else:
                # if not row.has_attr('bgcolor'):
                pieces = row.findAll('td')
                id_type_agency = dict(parse_id_and_type(pieces[0]).items() + {'agency': agency,'county': county}.items())
                reporting_officer = {'reporting_officer': pieces[2].text}
                parse_details(pieces[1], id_type_agency, reporting_officer)
    # for incident_type, incidents in scraper_commands.all_data.iteritems():
    #     for incident in incidents:
    #         print incident
    return scraper_commands.all_data
