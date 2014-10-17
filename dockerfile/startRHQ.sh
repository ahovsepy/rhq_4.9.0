trap 'rhq_exit; exit' SIGINT SIGQUIT
count=0

rhq_exit()
{
echo "you hit Ctrl-C/Ctrl-\, now exiting.."
 su root -c './opt/rhq-server-4.9.0/bin/rhqctl stop'
}
#start postgresql server
su -l postgres -c " pg_ctl -l server.log -w stop; pg_ctl -l server.log -w start; "
echo "Waiting 30s for DB to startup"
sleep 30s
#install and start rhq server/storage/agent
su root -c ' ./opt/rhq-server-4.9.0/bin/rhqctl install --agent-preference="127.0.0.1" '
sleep 30s
su root -c './opt/rhq-server-4.9.0/bin/rhqctl start'
#tail server.log
su root -c 'tail -f /opt/rhq-server-4.9.0/logs/server.log'

