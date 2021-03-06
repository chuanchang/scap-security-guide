# platform = Red Hat Enterprise Linux 6
. /usr/share/scap-security-guide/remediation_functions
populate sysctl_net_ipv6_conf_default_accept_redirects_value

#
# Set runtime for net.ipv6.conf.default.accept_redirects
#
/sbin/sysctl -q -n -w net.ipv6.conf.default.accept_redirects=$sysctl_net_ipv6_conf_default_accept_redirects_value

#
# If net.ipv6.conf.default.accept_redirects present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv6.conf.default.accept_redirects = value" to /etc/sysctl.conf
#
if grep --silent ^net.ipv6.conf.default.accept_redirects /etc/sysctl.conf ; then
	sed -i "s/^net.ipv6.conf.default.accept_redirects.*/net.ipv6.conf.default.accept_redirects = $sysctl_net_ipv6_conf_default_accept_redirects_value/g" /etc/sysctl.conf
else
	echo -e "\n# Set net.ipv6.conf.default.accept_redirects to $sysctl_net_ipv6_conf_default_accept_redirects_value per security requirements" >> /etc/sysctl.conf
	echo "net.ipv6.conf.default.accept_redirects = $sysctl_net_ipv6_conf_default_accept_redirects_value" >> /etc/sysctl.conf
fi
