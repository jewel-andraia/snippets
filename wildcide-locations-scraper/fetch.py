import urllib2, cgi
import demjson 
import csv

url = 'http://thewildcide.com/map/location_list.js'
output = 'wildcide.csv'
columns = ['name', 'address', 'city', 'state', 'zip' ]

r = urllib2.urlopen(url)
_, params = cgi.parse_header(r.headers.get('Content-Type', ''))
encoding = params.get('charset', 'utf-8')
unicode_text = r.read().decode(encoding)

start = unicode_text.index(u'[')
end = unicode_text.rindex(u']') + 1
rawjson = unicode_text[start:end]

locations = demjson.decode(rawjson, allow_trailing_comma=True)
rows = [ [ row[column].encode('utf-8') for column in columns ] for row in locations ]

with open(output, 'wb') as fout:
	writer = csv.writer(fout)
	writer.writerow(columns)
	for row in rows:
		writer.writerow(row)
	

print('Scraped %s to %s' % (url, output))
