from area53 import route53
from boto.route53.exception import DNSServerError
import requests
import sys
from datetime import datetime

# Modified from https://markcaudill.me/blog/2012/07/dynamic-route53-dns-updating-with-python/

domain = sys.argv[0] # 'devnotnull.com'
subdomain = sys.argv[1] #'nginx'

def get_public_ip():
    r = requests.get('http://icanhazip.com')
    return r.text.rstrip()

sys.argv[0]

fqdn = '%s.%s' % (subdomain, domain)
zone = route53.get_zone(domain)
arec = zone.get_a(fqdn)
new_value = get_public_ip()
datestr = '"Last update %s."' % datetime.utcnow().strftime('%Y-%m-%d %H:%M')

if arec:
        old_value = arec.resource_records[0]

        if old_value == new_value:
                print('%s is current. (%s)' % (fqdn, new_value))
                sys.exit(0)

        print('Updating %s: %s -> %s' % (fqdn, old_value, new_value))

        try:
                zone.update_a(fqdn, new_value, 900)
                zone.update_txt(fqdn, datestr, 900)

        except DNSServerError:
                # This can happen if the record did not already exist. Let's
                # try to add_a in case that's the case here.
                zone.add_a(fqdn, new_value, 900)
                zone.add_txt(fqdn, datestr, 900)
else:
        zone.add_a(fqdn, new_value, 900)
        zone.add_txt(fqdn, datestr, 900)