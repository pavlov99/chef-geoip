maintainer       "Kirill Pavlov"
maintainer_email "kirill.pavlov@phystech.edu"
license          "MIT"
description      "Installs MaxMind GeoIP  binaries and databases"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.0"

recipe "geoip", "Installs the geoip lookup binaries and the GeoLite Country database."
recipe "geoip::city", "Installs the GeoLite City database"
supports "ubuntu"
