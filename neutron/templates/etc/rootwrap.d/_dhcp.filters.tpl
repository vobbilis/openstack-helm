# neutron-rootwrap command filters for nodes on which neutron is
# expected to control network
#
# This file should be owned by (and only-writeable by) the root user

# format seems to be
# cmd-name: filter-name, raw-command, user, args

[Filters]

# dhcp-agent
dnsmasq: CommandFilter, dnsmasq, root
# dhcp-agent uses kill as well, that's handled by the generic KillFilter
# it looks like these are the only signals needed, per
# neutron/agent/linux/dhcp.py
kill_dnsmasq: KillFilter, root, /sbin/dnsmasq, -9, -HUP, -15
kill_dnsmasq_usr: KillFilter, root, /usr/sbin/dnsmasq, -9, -HUP, -15

ovs-vsctl: CommandFilter, ovs-vsctl, root
ivs-ctl: CommandFilter, ivs-ctl, root
mm-ctl: CommandFilter, mm-ctl, root
dhcp_release: CommandFilter, dhcp_release, root
dhcp_release6: CommandFilter, dhcp_release6, root

# metadata proxy
metadata_proxy: CommandFilter, neutron-ns-metadata-proxy, root
# RHEL invocation of the metadata proxy will report /usr/bin/python
kill_metadata: KillFilter, root, python, -9
kill_metadata7: KillFilter, root, python2.7, -9

# ip_lib
ip: IpFilter, ip, root
find: RegExpFilter, find, root, find, /sys/class/net, -maxdepth, 1, -type, l, -printf, %.*
ip_exec: IpNetnsExecFilter, ip, root
