#
# Cookbook Name:: geoip
# Recipe:: city
#
# Installs GeoIP City database
#
include_recipe "geoip"

last_updated = node['geoip']['city_db_updated'] || 0

if (Time.new.to_i - last_updated) > 60 * 60 * 30 then
    node.set['geoip']['city_db_updated'] = Time.new.to_i
    bash "remove old GeoIPCity database" do
        user "root"
        cwd node.geoip.directory
        code <<-EOH
            rm #{node.geoip.city_db_file}
        EOH
        only_if "test -f #{node.geoip.directory}#{node.geoip.city_db_file}"
    end
end

remote_file "#{node.geoip.directory}#{node.geoip.city_db_file}.download.gz" do
  source node.geoip.city_download_link
  mode 0644
  not_if "test -f #{node.geoip.directory}#{node.geoip.city_db_file}"
end

bash "unzip_and_link_db" do
    user "root"
    cwd node.geoip.directory
    code <<-EOH
        gunzip #{node.geoip.city_db_file}.download.gz
        mv #{node.geoip.city_db_file}.download #{node.geoip.city_db_file}
    EOH
    not_if "test -f #{node.geoip.directory}#{node.geoip.city_db_file}"
end
